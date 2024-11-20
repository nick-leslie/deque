import gleam/deque
import gleam/int
import gleam/list
import gleam/pair
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn from_and_to_list_test() {
  deque.from_list([])
  |> should.equal(deque.new())

  [1]
  |> deque.from_list
  |> deque.to_list
  |> should.equal([1])

  [1, 2]
  |> deque.from_list
  |> deque.to_list
  |> should.equal([1, 2])

  [1, 2, 3]
  |> deque.from_list
  |> deque.to_list
  |> should.equal([1, 2, 3])
}

pub fn is_empty_test() {
  deque.new()
  |> deque.is_empty
  |> should.be_true

  deque.from_list([""])
  |> deque.is_empty
  |> should.be_false
}

pub fn length_test() {
  let testcase = fn(input) {
    deque.from_list(input)
    |> deque.length
    |> should.equal(list.length(input))
  }

  testcase([])
  testcase([1])
  testcase([1, 2])
  testcase([1, 2, 1])
  testcase([1, 2, 1, 5, 2, 7, 2, 7, 8, 4, 545])
}

pub fn push_back_test() {
  [1, 2]
  |> deque.from_list
  |> deque.push_back(3)
  |> deque.to_list
  |> should.equal([1, 2, 3])

  deque.new()
  |> deque.push_back(1)
  |> deque.push_back(2)
  |> deque.push_back(3)
  |> deque.to_list
  |> should.equal([1, 2, 3])
}

pub fn push_front_test() {
  [2, 3]
  |> deque.from_list
  |> deque.push_front(1)
  |> deque.push_front(0)
  |> deque.to_list
  |> should.equal([0, 1, 2, 3])
}

pub fn push_test() {
  deque.new()
  |> deque.push_front("b")
  |> deque.push_back("x")
  |> deque.push_front("a")
  |> deque.push_back("y")
  |> deque.to_list
  |> should.equal(["a", "b", "x", "y"])
}

pub fn pop_back_test() {
  let assert Ok(tup) =
    [1, 2, 3]
    |> deque.from_list
    |> deque.pop_back

  tup
  |> pair.first
  |> should.equal(3)

  tup
  |> pair.second
  |> deque.is_equal(deque.from_list([1, 2]))
  |> should.be_true
}

pub fn pop_back_after_push_back_test() {
  let assert Ok(tup) =
    deque.new()
    |> deque.push_back(1)
    |> deque.push_back(2)
    |> deque.push_back(3)
    |> deque.pop_back

  tup
  |> pair.first
  |> should.equal(3)
}

pub fn pop_back_after_push_test() {
  let assert Ok(tup) =
    deque.new()
    |> deque.push_front("b")
    |> deque.push_back("x")
    |> deque.push_front("a")
    |> deque.push_back("y")
    |> deque.pop_back

  tup
  |> pair.first
  |> should.equal("y")
}

pub fn pop_back_empty_test() {
  deque.from_list([])
  |> deque.pop_back
  |> should.equal(Error(Nil))
}

pub fn pop_front_test() {
  let assert Ok(tup) =
    [1, 2, 3]
    |> deque.from_list
    |> deque.pop_front

  tup
  |> pair.first
  |> should.equal(1)

  tup
  |> pair.second
  |> deque.is_equal(deque.from_list([2, 3]))
  |> should.be_true
}

pub fn pop_front_after_push_front_test() {
  let assert Ok(tup) =
    deque.new()
    |> deque.push_front(3)
    |> deque.push_front(2)
    |> deque.push_front(1)
    |> deque.pop_front

  tup
  |> pair.first
  |> should.equal(1)
}

pub fn pop_front_after_push_test() {
  let assert Ok(tup) =
    deque.new()
    |> deque.push_front("b")
    |> deque.push_back("x")
    |> deque.push_front("a")
    |> deque.pop_front

  tup
  |> pair.first
  |> should.equal("a")
}

pub fn pop_front_empty_test() {
  deque.from_list([])
  |> deque.pop_front
  |> should.equal(Error(Nil))
}

pub fn reverse_test() {
  deque.from_list([1, 2, 3])
  |> deque.reverse
  |> deque.to_list
  |> should.equal([3, 2, 1])

  deque.new()
  |> deque.push_back(1)
  |> deque.push_back(2)
  |> deque.push_back(3)
  |> deque.reverse
  |> deque.to_list
  |> should.equal([3, 2, 1])

  deque.new()
  |> deque.push_front(1)
  |> deque.push_front(2)
  |> deque.push_front(3)
  |> deque.reverse
  |> deque.to_list
  |> should.equal([1, 2, 3])

  deque.new()
  |> deque.push_front(1)
  |> deque.push_front(2)
  |> deque.push_back(3)
  |> deque.push_back(4)
  |> deque.reverse
  |> deque.to_list
  |> should.equal([4, 3, 1, 2])
}

pub fn is_equal_test() {
  let should_equal = fn(a, b) {
    a
    |> deque.is_equal(to: b)
    |> should.be_true
  }

  let should_not_equal = fn(a, b) {
    a
    |> deque.is_equal(to: b)
    |> should.be_false
  }

  should_equal(deque.new(), deque.new())

  deque.new()
  |> deque.push_front(1)
  |> should_equal(
    deque.new()
    |> deque.push_back(1),
  )

  deque.new()
  |> deque.push_front(1)
  |> should_equal(
    deque.new()
    |> deque.push_front(1),
  )

  deque.new()
  |> deque.push_back(1)
  |> deque.push_back(2)
  |> should_equal(
    deque.new()
    |> deque.push_front(2)
    |> deque.push_front(1),
  )

  deque.new()
  |> deque.push_back(1)
  |> should_not_equal(
    deque.new()
    |> deque.push_front(2)
    |> deque.push_front(1),
  )

  deque.new()
  |> deque.push_back(2)
  |> deque.push_back(1)
  |> should_not_equal(
    deque.new()
    |> deque.push_front(2)
    |> deque.push_front(1),
  )
}

pub fn is_logically_equal_test() {
  let both_even_or_odd = fn(a, b) { int.is_even(a) == int.is_even(b) }

  let should_equal = fn(a, b) {
    a
    |> deque.is_logically_equal(to: b, checking: both_even_or_odd)
    |> should.be_true
  }

  let should_not_equal = fn(a, b) {
    a
    |> deque.is_logically_equal(to: b, checking: both_even_or_odd)
    |> should.be_false
  }

  should_equal(deque.new(), deque.new())

  deque.new()
  |> deque.push_front(3)
  |> should_equal(
    deque.new()
    |> deque.push_back(1),
  )

  deque.new()
  |> deque.push_front(4)
  |> should_equal(
    deque.new()
    |> deque.push_back(2),
  )

  deque.new()
  |> deque.push_front(3)
  |> should_equal(
    deque.new()
    |> deque.push_front(1),
  )

  deque.new()
  |> deque.push_back(3)
  |> deque.push_back(4)
  |> should_equal(
    deque.new()
    |> deque.push_front(2)
    |> deque.push_front(1),
  )

  deque.new()
  |> deque.push_back(1)
  |> should_not_equal(
    deque.new()
    |> deque.push_front(2)
    |> deque.push_front(1),
  )

  deque.new()
  |> deque.push_back(2)
  |> deque.push_back(1)
  |> should_not_equal(
    deque.new()
    |> deque.push_front(2)
    |> deque.push_front(1),
  )

  deque.new()
  |> deque.push_back(4)
  |> deque.push_back(3)
  |> should_not_equal(
    deque.new()
    |> deque.push_front(2)
    |> deque.push_front(1),
  )
}
