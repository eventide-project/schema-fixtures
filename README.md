# Schema Fixtures

[TestBench](http://test-bench.software/) fixtures for the [Schema](https://github.com/eventide-project/schema) library

The Schema Fixture library provides two [TestBench test fixtures](http://test-bench.software/user-guide/fixtures.html) for working with objects that are implementations of `Schema`, including `Schema::DataStructure`, and other implementations in other libraries, such as message objects based on the Eventide Project's `Messaging::Message`.

## Fixtures

A fixture is a pre-defined, reusable test abstraction. The objects under test are specified at runtime so that the same standardized test implementation can be used against multiple objects.

A fixture is just a plain old Ruby object that includes the TestBench API. A fixture has access to the same API that any TestBench test would. By including the `TestBench::Fixture` module into a Ruby object, the object acquires all of the methods available to a test script, including context, test, assert, refute, assert_raises, refute_raises, and comment.

## Equality Fixture

The `Schema::Fixtures::Equality` fixture tests the equality of two instances of a schema object. It optionally tests that the classes of each schema object are the same class, and tests that the attributes of the schema instances have the same values. The attributes tested can be limited to a subset of attributes by specifying a list of attribute names, and a map can be provided to compare different attributes to each other.

``` ruby
module Something
  class Example
    include Schema

    attribute :some_attribute
    attribute :some_other_attribute
  end
end

context 'Equal' do
  example_1 = Something::Example.new
  example_1.some_attribute = 'some value'
  example_1.some_other_attribute = 'some other value'

  example_2 = Something::Example.new
  example_2.some_attribute = 'some value'
  example_2.some_other_attribute = 'some other value'

  fixture(Equality, example_1, example_2)
end
```

Running the test is no different than [running any TestBench test](http://test-bench.software/user-guide/running-tests.html). In its simplest form, running the test is done by passing the test file name to the `ruby` executable.

``` bash
ruby test/equal.rb
```

The test script and the fixture work together as if they are the same test.

```
Equal
  Schema Equality: Example, Example
    Classes are the same
    Attributes
      some_attribute
      some_other_attribute
```

The output from the "Schema Equality" line-downward is from the Equality fixture.

### Detailed Output

The fixture will print more detailed output if the `TEST_BENCH_DETAIL` environment variable is set to `on`.

``` bash
TEST_BENCH_DETAIL=on ruby test/equal.rb
```

```
Equal
  Schema Equality: Example, Example
    Control Class: Something::Example
    Compare Class: Something::Example
    Classes are the same
    Attributes
      some_attribute
        Control Value: "some value"
        Compare Value: "some value"
      some_other_attribute
        Control Value: "some other value"
        Compare Value: "some other value"
```

### Failed Tests

The fixture will fail if any of the fixture's equality tests fail.

When a test fails in the fixture, the effect is identical to a test failure in a TestBench test script.

``` ruby
context 'Equal' do
  example_1 = Something::Example.new
  example_1.some_attribute = 'some value'
  example_1.some_other_attribute = 'some other value'

  example_2 = Something::Example.new
  example_2.some_attribute = 'some value'
  example_2.some_other_attribute = SecureRandom.hex

  fixture(Equality, example_1, example_2)
end
```

``` bash
ruby test/equal.rb
```

#### Failed Tests and Detailed Output

When a test within a fixture fails, the fixture's detailed output will print irrespective of the value of the `TEST_BENCH_DETAIL` environment variable.

```
Equal
  Schema Equality: Example, Example
    Control Class: Something::Example
    Compare Class: Something::Example
    Classes are the same
    Attributes
      some_attribute
        Control Value: "some value"
        Compare Value: "some value"
      some_other_attribute
        Control Value: "some other value"
        Compare Value: "76e107f5496d45558944e8c609bec1d7"
        /schema-fixtures/lib/schema/fixtures/equality.rb:45:in `block (4 levels) in call': Assertion failed (TestBench::Fixture::AssertionFailure)
```

### Limiting to Certain Attributes

The Equality fixture can limit the attribute tests to a subset of attributes by specifying a list of attributes to test.

``` ruby
context 'Equal' do
  example_1 = Something::Example.new
  example_1.some_attribute = 'some value'
  example_1.some_other_attribute = 'some other value'

  example_2 = Something::Example.new
  example_2.some_attribute = 'some value'
  example_2.some_other_attribute = SecureRandom.hex

  attribute_names = [:some_attribute]

  fixture(Equality, example_1, example_2, attribute_names)
end
```

```
Equal
  Schema Equality: Example, Example
    Classes are the same
    Attributes
      some_attribute
```

### Ignoring the Classes

Instances of different schemas classes with the same attribute names can be compared to each other by specifying that the fixture ignore the schema objects' classes.

``` ruby
module Something
  class OtherExample
    include Schema

    attribute :some_attribute
    attribute :some_other_attribute
  end
end

context 'Equal' do
  example = Something::Example.new
  example.some_attribute = 'some value'
  example.some_other_attribute = 'some other value'

  other_example = Something::OtherExample.new
  other_example.some_attribute = 'some value'
  other_example.some_other_attribute = 'some other value'

  attribute_names = [:some_attribute]

  fixture(Equality, example, other_example, ignore_class: true)
end
```

```
Equal
  Schema Equality: Example, OtherExample
    Attributes
      some_attribute
      some_other_attribute
```

If the `ignore_class` parameter is not `true`, and the two schema classes are not the same class, the fixture will fail.

``` ruby
context 'Equal' do
  example = Something::Example.new
  example.some_attribute = 'some value'
  example.some_other_attribute = 'some other value'

  other_example = Something::OtherExample.new
  other_example.some_attribute = 'some value'
  other_example.some_other_attribute = 'some other value'

  attribute_names = [:some_attribute]

  fixture(Equality, example, other_example)
end
```

```
Equal
  Schema Equality: Example, OtherExample
    Control Class: Something::Example
    Compare Class: Something::OtherExample
    Classes are the same
      /schema-fixtures/lib/schema/fixtures/equality.rb:28:in `block (2 levels) in call': Assertion failed (TestBench::Fixture::AssertionFailure)
    Attributes
      some_attribute
        Control Value: "some value"
        Compare Value: "some value"
      some_other_attribute
        Control Value: "some other value"
        Compare Value: "some other value"
```

Note: The default value of the `ignore_class` parameter `false`. Unless it's explicitly set to `true`, the classes will always be tested.

### Comparing Different Schemas Using a Map

The equality of the attribute values of two different schema classes that have different attribute names that represent the same values can be tested using a map of the attribute names.

``` ruby
module Something
  class YetAnotherExample
    include Schema

    attribute :some_attribute
    attribute :yet_another_attribute
  end
end

context 'Equal' do
  example = Something::Example.new
  example.some_attribute = 'some value'
  example.some_other_attribute = 'some other value'

  other_example = Something::YetAnotherExample.new
  other_example.some_attribute = 'some value'
  other_example.yet_another_attribute = 'some other value'

  map = [
    :some_attribute,
    :some_other_attribute => :yet_another_attribute
  ]

  fixture(Equality, example, other_example, map, ignore_class: true)
end
```

```
Equal
  Schema Equality: Example, YetAnotherExample
    Class comparison is ignored
    Attributes
      some_attribute
      some_other_attribute => yet_another_attribute
```

Note that when an attribute map is used, the attribute name printed by the fixture is the pair of mapped attributes.

### Equality Fixture API

Class: `Schema::Fixtures::Equality`

#### Construct the Equality Fixture

``` ruby
self.build(control, compare, attribute_names=[], ignore_class: false)
```

**Returns**

`Schema::Fixtures::Equality`

**Parameters**

| Name | Description | Type | Default |
| --- | --- | --- | --- |
| control | Baseline object for comparison | Schema |
| compare | Object to compare to the baseline | Schema |
| attribute_names | Optional list of attribute names to limit testing to | Array of Symbol or Hash | Attribute names of left-hand side object |
| ignore_class | Optionally controls whether the classes of the objects are considered in the evaluation of equality | Boolean | false |

#### Actuating the Fixture

``` ruby
call()
```

## Assignment Fixture

The `Schema::Fixtures::Assignment` fixture tests that a schema instance's attributes have been assigned a value. The attributes tested can be limited to a subset of attributes by specifying a list of attribute names.

``` ruby
context 'Assigned' do
  example = Something::Example.new
  example.some_attribute = 'some value'
  example.some_other_attribute = 'some other value'

  fixture(Assignment, example)
end
```

```
Assigned
  Schema Assignment: Example
    Attributes
      some_attribute
      some_other_attribute
```

### Detailed Output

The fixture will print more detailed output if the `TEST_BENCH_DETAIL` environment variable is set to `on`.

``` bash
TEST_BENCH_DETAIL=on ruby test/assigned.rb
```

```
Assigned
  Schema Assignment: Example
    Class: Something::Example
    Attributes
      some_attribute
        Default Value: nil
        Assigned Value: "some value"
      some_other_attribute
        Default Value: nil
        Assigned Value: "some other value"
```

### Failed Tests

The fixture will fail if any of the fixture's assignment tests fail.

When a test fails in the fixture, the effect is identical to a test failure in a TestBench test script.

``` ruby
context 'Assigned' do
  example = Something::Example.new

  fixture(Assignment, example)
end
```

```
Assigned
  Schema Assignment: Example
    Class: Something::Example
    Attributes
      some_attribute
        Default Value: nil
        Assigned Value: nil
        /schema-fixtures/lib/schema/fixtures/assignment.rb:30:in `block (4 levels) in call': Assertion failed (TestBench::Fixture::AssertionFailure)
      some_other_attribute
        Default Value: nil
        Assigned Value: nil
        /schema-fixtures/lib/schema/fixtures/assignment.rb:30:in `block (4 levels) in call': Assertion failed (TestBench::Fixture::AssertionFailure)
```

Note that when a test within a fixture fails, the fixture's detailed output will print irrespective of the value of the `TEST_BENCH_DETAIL` environment variable.

#### Determination of Assignment and Default Values

Am attribute is determined to have been assigned a value if the attribute's value is no longer equal to its default value.

An attribute's default value may be defined as something other than `nil`.

If an attribute has been explicitly assigned a value that is equal to its default value, it's considered to have not been assigned at all, which is considered a failed assignment test.

In order for assignment tests to pass, the value of attributes have to be other than their default values.

``` ruby
module DefaultValue
  class Example
    include ::Schema

    attribute :some_attribute, default: 'some default value'
    attribute :some_other_attribute
  end
end

context 'Assigned' do
  example = DefaultValue::Example.new
  example.some_attribute = 'some default value'
  example.some_other_attribute = nil

  fixture(Assignment, example)
end
```

```
Assigned
  Schema Assignment: Example
    Class: DefaultValue::Example
    Attributes
      some_attribute
        Default Value: 'some default value'
        Assigned Value: 'some default value'
        /schema-fixtures/lib/schema/fixtures/assignment.rb:30:in `block (4 levels) in call': Assertion failed (TestBench::Fixture::AssertionFailure)
      some_other_attribute
        Default Value: nil
        Assigned Value: nil
        /schema-fixtures/lib/schema/fixtures/assignment.rb:30:in `block (4 levels) in call': Assertion failed (TestBench::Fixture::AssertionFailure)
```

### Limiting to Certain Attributes

The Assignment fixture can limit the attribute tests to a subset of attributes by specifying a list of attributes to test.

``` ruby
context 'Equal' do
  example = Something::Example.new
  example.some_attribute = 'some value'

  attribute_names = [:some_attribute]

  fixture(Assignment, example, attribute_names)
end
```

```
Assigned
  Schema Assignment: Example
    Attributes
      some_attribute
```

### Equality Fixture API

Class: `Schema::Fixtures::Assignment`

#### Construct the Assignment Fixture

``` ruby
self.build(schema, attribute_names=[])
```

**Returns**

`Schema::Fixtures::Assignment`

**Parameters**

| Name | Description | Type | Default |
| --- | --- | --- | --- |
| schema | The schema object whose attributes will be tested for assignment | Schema |
| attribute_names | Optional list of attribute names to limit testing to | Array of Symbol | Attribute names of teh schema object |

#### Actuating the Fixture

``` ruby
call()
```

## License

The `schema-fixtures` library is released under the [MIT License](https://github.com/eventide-project/schema-fixtures/blob/master/MIT-License.txt).
