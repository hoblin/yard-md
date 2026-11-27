# class Rake::LinkedList
Includes: `Enumerable`
Defined in: `lib/rake/linked_list.rb`

Polylithic linked list structure used to implement several data
structures in Rake.

## Instance attributes

### #head (read-only)

Returns the value of attribute head.

### #tail (read-only)

Returns the value of attribute tail.

## Class methods

### .cons(head, tail)

Cons a new head onto the tail list.

### .empty

The standard empty list class for the given LinkedList class.

### .make(*args)

Make a list out of the given arguments. This method is
polymorphic

## Instance methods

### #==(other)

Lists are structurally equivalent.

### #conj(item)

Polymorphically add a new element to the head of a list. The
type of head node will be the same list type as the tail.

### #each

For each item in the list.

### #empty?

Is the list empty?
.make guards against a list being empty making any instantiated LinkedList
object not empty by default
You should consider overriding this method if you implement your own .make method

Returns: `Boolean`

### #inspect

Same as `to_s`, but with inspected items.

### #to_s

Convert to string: LL(item, item...)
