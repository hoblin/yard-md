# class Rake::LinkedList::EmptyLinkedList < LinkedList
Defined in: `lib/rake/linked_list.rb`

Represent an empty list, using the Null Object Pattern.

When inheriting from the LinkedList class, you should implement
a type specific Empty class as well. Make sure you set the class
instance variable @parent to the associated list class (this
allows conj, cons and make to work polymorphically).

## Class methods

### .cons(head, tail)

## Instance methods

### #empty?

Returns: `Boolean`

### #initialize
