struct Path
    source::Int
    target::Union{Int,Path}
end

function path(s::Int)
    return Path(s,s)    
end

function path(s::Int,p::Path)
    return Path(s,p)    
end

function path(s::Int,t::Int)
    return Path(s,t)    
end

function path(s::Path,p::Path)
    return Path(s.source,path(s.target,p))
end

# TODO: change * to U+21D2
infix = "*"
⋆(s::Int, t::Int) = path(s, t)
⋆(s::Int, p::Path) = path(s, p)

function Base.show(io::IO, p::Path)
    print(io, p.source)
    if isa(p.target, Path)
        print(io, infix)
        show(io, p.target)
    else
        print(io, infix, p.target)
    end
end

#AI code to test these function:
# Defining tasks
task1 = 1 ⋆ 2           # Task 1 leads to Task 2
task2 = 3 ⋆ task1       # Task 3 follows Task 1 -> Task 2
task3 = 4 ⋆ task2       # Task 4 follows Task 3 -> Task 1 -> Task 2

# Displaying the task sequence
println(task1)  # Output: 1 * 2 (will become 1 ⇒ 2 after replacing `infix`)
println(task2)  # Output: 3 * 1 * 2
println(task3)  # Output: 4 * 3 * 1 * 2
