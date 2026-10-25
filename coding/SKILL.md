---
name: coding
description: Write, refactor, and design code. Use this skill whenever writing or reviewing non-trivial code, designing modules, APIs, data models or architecture, or refactoring. Prefer it for any request to produce code that must stay understandable and changeable over time.
---

# Coding

This skill includes information related to good code design. It consists of a list of rules to be followed

## Prefer simplicity over ease

Most software pain comes from confusing two different things, and picking the wrong one.

- **Simple** means *one fold*: a thing with one role, one concept, one job, not interleaved with others. It is an objective property of the artifact. The opposite is **complex**, which means braided together.
- **Easy** means *near at hand*: familiar, already installed, within our current skills. It is relative to the person. The opposite is *hard*.

Easy is about the author's comfort today. Simple is about whether anyone can understand, change, test, and debug the thing later. Code that is easy to write and tangled to read is the default failure mode.

* **Judge code by braids, not artifact count**. Code quality is determined by how "braided" together concepts are. Simplicity is not fewer lines, fewer classes, or fewer files. Ten small independent functions are simpler to reason about than one function with three interleaved concerns. Never collapse code together just to reduce the count.

* **Reasoning is the budget.** People can hold only a few things in their head at once. Every braid forces the reader to consider several things at once. Tests, types, and refactoring are guard rails: they catch some crashes but do not make the code any easier to understand. Write them, but do not lean on them to excuse tangled design. Every bug that reached production passed the type checker and the test suite.

Given a task, this is how to approach coding it:

1. **Name the roles.** Before writing, list what the code must do by asking *what* (the operations), *who* (the parties or components), *when* (ordering and timing), *where* (location or storage), *why* (the rules and policies), and *how* (the mechanism). Each answer that you would want to change independently of another is a separate piece.
2. **Look for braids.** Scan the plan for tangled concepts . A braid is anything where changing one concern forces you to touch or reason about another.
3. **Pull apart.** Give each role its own piece. Prefer the simple construct. Treat the "how" as replaceable and the "what" as stable.
4. **Compose.** Build the behavior by combining the independent pieces. Composition of simple parts is how complex systems stay understandable. Push effects (I/O, clocks, randomness, mutation) to the outer edge and keep the core a pure transformation of values.
5. **Check.** Can each piece be read, tested, and replaced without the others? Can you state what it does in one sentence without "and"? If not, there is still a braid.

### Rules of thumb

- **Functions of their arguments.** If a function needs something, take it as a parameter. Hidden inputs (globals, singletons, the clock) braid the function with its environment.
- **Functions should composable.** It is better to have a function which can be used as a building block for other functions.
- **Effects at the edge.** Keep a pure core and a thin shell that does I/O. The core is trivial to test and reason about; the shell is small enough to inspect.
- **Abstraction means drawing away from the how.** A good abstraction states *what* is wanted and hides the mechanism. If the abstraction's interface leaks the mechanism (a "StorageManager" that exposes connection handling), it is not abstracting; it is renaming.
- **Separate policy from mechanism.** Rules (discount tiers, retry limits, quiet hours) belong in data or one small decision function, not scattered through the code that executes them.
- **Order is a hidden dependency.** If two steps must happen in a particular sequence for correctness and nothing in the code says so, that is a braid. Make the dependency explicit in the data flow (output of one is input of the next) or use a queue or pipeline.
- **Take things apart first.** Design is mostly the act of decomposing. If you cannot say which pieces exist, you cannot yet say what is simple. Reduce everything to atomic actions which can be combined together to make our program.
- **Stay idiomatic.** Use the language's own tools for values and functions (dataclasses with `frozen=True`, `readonly` and `as const` in TypeScript, records in Java, immutable-by-default bindings in Rust). Honor the existing codebase's conventions unless the user asks for a redesign.
- **Easy is still allowed.** For throwaway scripts and prototypes, the easy path is fine. The rule is that ease must not be what decides the structure of code that will live. When you do choose something easy but tangled, say so in one line.
- **Contain what you cannot remove.** If a framework, ORM, or legacy module forces a braid, quarantine it behind a narrow boundary and keep the rest of the code free of it.
- **Do not abstract speculatively.** A pile of indirection layers is itself a braid, because every layer must be understood to follow one call. Introduce a seam only where two roles actually need to vary independently.
- **Do not widen the scope.** When asked to fix one function, do not rewrite the module. Point out larger tangles you noticed and let the user decide.

## Honest vs. dishonest functions

For a long time, programmers have preferred "pure" over "impure" functions. While pure functions have nice properties and are generally preferred, their definition is slightly restrictive. Instead we prefer *honest* over *dishonest* functions

Honest functions:
* **Have a clear signature.** The signature should completely represent the inputs and outputs of the function.
* **Are deterministic.**
* **Are a superset of pure functions.** All pure functions are honest about what they take in (in the function signature), what they return (in the function signature), what state they rely on (all local state), and what state they mutate (none, at least state external to the function). They abide by local reasoning.
* **Are allowed to mutate.** Mutation is okay, so long as the function is clear about what it is mutating (in the function signature). Think for instance `my_arr.clear()` or `my_arr.sort()` or `my_arr<T>.filter(func(T) -> Bool)`. These functions are technically 'impure,' but that is okay as long as we can still reason about what the function is doing and what it is acting upon. Note that this mutation is still deterministic.
* **Are testable.**
* **Use local reasoning.**

Dishonest functions:
* **Are not deterministic.**
* **Rely on information outside of the function signature**
* **Include side effects.** Side effects are okay though. We will need those in every program we write. Dishonest functions are needed, but should be a thin wrapper around our program logic. Think of `print()`, `draw_to_screen()`, or `file_descriptor.write(my_data)`.
* **Are viral.** An honest function which calls a dishonest function becomes a dishonest function.
* **Are difficult to test.**
* **Are difficult to reason about.**

There is one form of function which does not neatly fit into either one of these categories: framework hooks. These are sometimes necessary, but should remain as minimal as possible, calling primarily into pure functions. These exist to glue code. Good examples of this include `update()` in React, or even the `main()` function in all programs (it is being 'hooked' into the OS runtime, in a sense).
Example:
```python
from itertools import permutations

def main(): # dishonest, through virality
    my_input = input() # dishonest
    sorted(my_input) # honest
    for s in permutations(my_input): # honest
        joined = "".join(s) # honest
        print(joined) # dishonest
```

Note how this function mixes honesty and dishonesty. And it braids together multiple concepts, both getting input from the user, computing permutations, and printing the permutations. The fix:

```python
from itertools import permutations
from typing import List

def get_permutations(ss: str) -> List[str]:
    """Completely honest function."""
    sorted(ss)
    return [
        "".join(s)
        for s in permutations(ss)
    ]


if __name__ == "__main__": # dishonest
    my_input = input() # dishonest
    perm = get_permutations(my_input) # honest
    for s in perm:
        print(s) # dishonest
```

This is longer, but it is easier to reason about, and now we have a testable function (`get_permutations`). We have also untangled multiple concepts from each other. This is also more modular. What if, instead of printing, we want to do file IO? It is easy to reuse the core functionality.

Practical advice:
1. Because dishonesty is viral, keep it at the edges of program.
1. Because honest functions have so many benefits, try to make as much of the program honest as possible.
1. Show that honesty through clearly function signatures. Assume users of that function *only* have access to the function signature and need to infer what to do just from that


## Documenting code

Code should be primarily documented through the function signature and variable names used within that function.

* Keyword arguments are good for being more descriptive for what is going on
* Creating structures which hold the set of arguments passed to a function is also a good pattern for describing what the function takes in. Note that this *does not* mean we pass entire classes around when we really only need a few values off of it. The point of creating a struct which holds function parameters is to better describe what the function does. Passing an entire class with irrelevant details included within it does not help readability and braids together systems.

Consider the following:
```python
# really bad
def add_to_db(db, customer, item, price, quantity):
    ...

# bad
def add_transaction_to_db(db: sqlite3.Connection, customer: str, item: Item, price: float, quantity: int) -> None:
    ...

# Better
@dataclass(frozen=True)
class Transaction:
    customer: str
    item: Item
    price: float
    quantity: int
def add_to_db(db: sqlite3.Connection, t: Transaction) -> None:
    ...

# Best
def add_to_db(db: sqlite3.Connection, t: Transaction) -> None:
    if not table_exists(db, table="transactions"):
        raise ValueError("Provided database does not contain table 'transactions'")
    ...
```

Most docstrings always have one sentence describing what a function/class/module does without "and." If a function/class/module cannot be described in such a way, it might need to be split up. The types of the input and types of the output should be descriptive enough to explain the input and output of a function. If a function has certain failure modes (i.e. `divide(dividend, divisor)` would fail when `divisor == 0`), then it is good practice to note this failure mode in the docstring.

**Code comments**:
* Comments should only mostly explain why a decision was made. Rarely ever is it appropriate to explain what is happening in the code or how it is being doine; the code should explain that through being sufficiently self-descriptive.
* Comments are never used to delineate between sections of the code. Code should be divided up by a clean ontological hierarchy (see the section on file structure)

## File structure

Organize code into modules, where each module has its own well defined role within the program and has no chance of overlapping with some other part of the program.

* Each submodule is an ontological subset of that module. For instance, a `data` module might have a submodule for each dataset we want to work with `dataset_a`, `dataset_b`, etc. If this itself needs to be broken up into multiple smaller files, then it is a directory. If it makes sense to group all the code we need for a given dataset into one file, then just make it one file.
* This inherently keeps related concepts close together, and unrelated concepts far apart.
* One responsibility per module. A file or function should be describable in a sentence without “and.” If it isn’t, it might need to be split up.
* Internal consistency is paramount.
* A good rule of thumb is that any given function should only ever have to use objects that are in the same module as itself (or a submodule of itself)
* Avoid creating 'junk drawer' modules, such as a `utils` file or a `misc/` module
* Try to keep folder depth shallow.
