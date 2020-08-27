# Schema Fixtures

[TestBench](http://test-bench.software/) fixtures for the [Schema](https://github.com/eventide-project/schema) library

The Schema Fixtures library provides [TestBench test fixtures](http://test-bench.software/user-guide/fixtures.html) for testing objects that are implementations of Eventide's `Schema`, including `Schema::DataStructure`, and other implementations in other libraries, such as message objects based on the Eventide Project's `Messaging::Message`.

## Fixtures

A fixture is a pre-defined, reusable test abstraction. The objects under test are specified at runtime so that the same standardized test implementation can be used against multiple objects.

A fixture is just a plain old Ruby object that includes the TestBench API. A fixture has access to the same API that any TestBench test would. By including the `TestBench::Fixture` module into a Ruby object, the object acquires all of the methods available to a test script, including context, test, assert, refute, assert_raises, refute_raises, and comment.

## Equality Fixture

The `Schema::Fixtures::Equality` fixture tests the comparison between two implementations of [Schema::DataStructure](https://github.com/eventide-project/schema), such as [messages](/user-guide/messages-and-message-data/messages.md) and [entities](/user-guide/entities.md).

By default, all attributes from the control schema object are compared to the compare schema object attributes of the same name. An optional list of attribute names can be passed. When the list of attribute names is passed, only those attributes will be compared. The list of attribute names can also contain maps of attribute names for comparing values when the control object attribute name is not the same as the compare object attribute name.

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

### Running the Fixture

Running the test is no different than [running any TestBench test](http://test-bench.software/user-guide/running-tests.html).

For example, given a test file named `schema_equality.rb` that uses the schema equality fixture, in a directory named `test`, the test is executed by passing the file name to the `ruby` executable.

``` bash
ruby test/schema_equality.rb
```

The test script and the fixture work together as if they are part of the same test context, preserving output nesting between the test script file and the test fixture.

### Schema Equality Fixture Output

``` text
Equal
  Schema Equality: Example, Example
    Classes are the same
    Attributes
      some_attribute
      some_other_attribute
```

The output from the "Schema Equality" line-downward is from the equality fixture.

### Detailed Output

In the event of any error or failed assertion, the test output will include additional detailed output that can be useful in understanding the context of the failure and the state of the fixture itself and the objects that it's testing.

The detailed output can also be printed by setting the `TEST_BENCH_DETAIL` environment variable to `on`.

``` bash
TEST_BENCH_DETAIL=on ruby test/schema_equality.rb
```

``` text
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

### Actuating the Schema Equality Fixture

The fixture is executed using TestBench's `fixture` method.

``` ruby
fixture(Schema::Fixtures::Equality, control, compare, attribute_names=[], ignore_class: false)
```

The first argument sent to the `fixture` method is always the `Schema::Fixtures::Equality` class. Subsequent arguments are the specific construction parameters of the schema equality fixture.

An optional list of attribute names can be passed. When the list of attribute names is passed, only those attributes will be compared. The list of attribute names can also contain maps of attribute names for comparing values when the entity attribute name is not the same as the event attribute name.

When the list of attribute names is not provided, it defaults to the attribute names of the control schema object.

**Parameters**

| Name | Description | Type |
| --- | --- | --- |
| control | Control schema object that is the baseline for the comparison | Schema |
| compare | Schema object that is compared to the control object | Schema |
| attribute_names | Optional list of attribute names to compare, or maps of event attribute name to entity attribute name | Array of Symbol or Hash |

### Limiting the Test to a Subset of Attributes

The Equality fixture can limit the attribute tests to a subset of attributes by specifying a list of attributes names.

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

``` text
Equal
  Schema Equality: Example, Example
    Classes are the same
    Attributes
      some_attribute
```

### Comparing Different Attribute Names Using a Map

The equality of the attribute values of two different schema classes that have different attribute names that represent the same values can be tested using a map of the attribute names.

The typical use case for this is the comparison of schema objects of different classes with different attribute names. In this case, the `ignore_class: true` argument usually accompanies a map of attribute names.

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

``` text
Equal
  Schema Equality: Example, YetAnotherExample
    Class comparison is ignored
    Attributes
      some_attribute
      some_other_attribute => yet_another_attribute
```

Note that when an attribute map is used, the attribute name printed by the fixture is the pair of mapped attributes.

### Ignoring the Class Comparison

By default, when two schema objects are compared, if the objects have different classes, they're not considered equal unless the class comparison is disabled.

The class comparison can be disabled by passing `true` as the value of the `ignore_class` keyword argument.

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

``` text
Equal
  Schema Equality: Example, OtherExample
    Attributes
      some_attribute
      some_other_attribute
```

## Assignment Fixture

The `Schema::Fixtures::Assignment` fixture tests that a schema instance's attributes have been assigned a value. The fixture is used to make sure that a schema object's attributes have been mutated in the course of some procedure.

If an attribute is declared with a default value, then the attribute must have been assigned another value for it to be considered mutated.

By default, all of schema object's attributes are asserted to have been mutated. An optional list of attribute names can be passed. When the list of attribute names is passed, only those attributes will be compared.

``` ruby
context 'Assigned' do
  example = Something.new
  example.some_attribute = 'some value'
  example.some_other_attribute = 'some other value'

  fixture(Assignment, example)
end
```

### Running the Fixture

Running the test is no different than [running any TestBench test](http://test-bench.software/user-guide/running-tests.html).

For example, given a test file named `schema_assignment.rb` that uses the schema assignment fixture, in a directory named `test`, the test is executed by passing the file name to the `ruby` executable.

``` bash
ruby test/schema_assignment.rb
```

The test script and the fixture work together as if they are part of the same test context, preserving output nesting between the test script file and the test fixture.

### Schema Assignment Fixture Output

``` text
Assigned
  Schema Assignment: Example
    Attributes
      some_attribute
      some_other_attribute
```

### Detailed Output

In the event of any error or failed assertion, the test output will include additional detailed output that can be useful in understanding the context of the failure and the state of the fixture itself and the objects that it's testing.

The detailed output can also be printed by setting the `TEST_BENCH_DETAIL` environment variable to `on`.

``` bash
TEST_BENCH_DETAIL=on ruby test/schema_assignment.rb
```

``` text
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

### Actuating the Assignment Fixture

The fixture is executed using TestBench's `fixture` method.

``` ruby
fixture(Schema::Fixtures::Assignment, schema, attribute_names=[])
```

The first argument sent to the `fixture` method is always the `Schema::Fixtures::Assignment` class. Subsequent arguments are the specific construction parameters of the assignment fixture.

When the list of attribute names is not provided, it defaults to all of the attribute names of the schema object.

**Parameters**

| Name | Description | Type |
| --- | --- | --- | --- |
| schema | The schema object whose attributes will be tested for assignment | Schema |
| attribute_names | Optional list of attribute names to check for assignment | Array of Symbol |

### Limiting the Test to a Subset of Attributes

The Assignment fixture can limit the attribute tests to a subset of attributes by specifying a list of attribute names.

``` ruby
context 'Equal' do
  example = Something::Example.new
  example.some_attribute = 'some value'

  attribute_names = [:some_attribute]

  fixture(Assignment, example, attribute_names)
end
```

``` text
Assigned
  Schema Assignment: Example
    Attributes
      some_attribute
```

### Determination of Assignment and Default Values

An attribute is determined to have been assigned a value if the attribute's value is no longer equal to its default value.

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

``` text
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

## More Documentation

More detailed documentation on the fixtures and their APIs can be found in the test fixtures user guide on the Eventide documentation site:

[http://docs.eventide-project.org/user-guide/test-fixtures/](http://docs.eventide-project.org/user-guide/test-fixtures/)

## License

The Schema Fixtures library is released under the [MIT License](https://github.com/eventide-project/schema-fixtures/blob/master/MIT-License.txt).
