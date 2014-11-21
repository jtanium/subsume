describe Subsume::Wrapper do

  subject do
    array_of_hashes = [
        {'first_name' => 'John', 'last_name' => 'Smith'},
        {'first_name' => 'Robert', 'last_name' => 'Morehouse'},
        {'first_name' => 'John', 'last_name' => 'Lack'},
        {'first_name' => 'Mary', 'last_name' => 'Greer'},
        {'first_name' => 'John', 'last_name' => 'Morehouse'},
        {'first_name' => 'Pamela', 'last_name' => 'Smith'},
        {'first_name' => 'Mary', 'last_name' => 'Lack'},
        {'first_name' => 'Robert', 'last_name' => 'Smith'},
        {'first_name' => 'Mary', 'last_name' => 'Smith'}
    ]

    Subsume::Wrapper.new(array_of_hashes)
  end
  it %q(lets you select hashes by a single value) do
    expect(subject.subsume('first_name' => 'John')).to eq([{'first_name' => 'John', 'last_name' => 'Smith'},
                                                           {'first_name' => 'John', 'last_name' => 'Lack'},
                                                           {'first_name' => 'John', 'last_name' => 'Morehouse'}])
  end
  it %q(lets you select hashes by multiple values) do
    expect(subject.subsume('first_name' => %w(Robert Pamela))).to eq([{'first_name' => 'Robert', 'last_name' => 'Morehouse'},
                                                                      {'first_name' => 'Pamela', 'last_name' => 'Smith'},
                                                                      {'first_name' => 'Robert', 'last_name' => 'Smith'}])
  end
  it %q(lets you select hashes by multiple keys) do
    expect(subject.subsume('first_name' => 'John', 'last_name' => 'Smith')).to eq([{'first_name' => 'John', 'last_name' => 'Smith'}])

    expect(subject.subsume('first_name' => %w(Robert Pamela), 'last_name' => 'Smith')).to eq([{'first_name' => 'Pamela', 'last_name' => 'Smith'},
                                                                                              {'first_name' => 'Robert', 'last_name' => 'Smith'}])
  end
  it %q(lets you exclude hashes by a single value) do
    expect(subject.exclude('first_name' => 'John')).to eq([{'first_name' => 'Robert', 'last_name' => 'Morehouse'},
                                                           {'first_name' => 'Mary', 'last_name' => 'Greer'},
                                                           {'first_name' => 'Pamela', 'last_name' => 'Smith'},
                                                           {'first_name' => 'Mary', 'last_name' => 'Lack'},
                                                           {'first_name' => 'Robert', 'last_name' => 'Smith'},
                                                           {'first_name' => 'Mary', 'last_name' => 'Smith'}])
  end
  it %q(lets you exclude hashes by multiple values) do
    expect(subject.exclude('first_name' => %w(John Mary))).to eq([{'first_name' => 'Robert', 'last_name' => 'Morehouse'},
                                                                  {'first_name' => 'Pamela', 'last_name' => 'Smith'},
                                                                  {'first_name' => 'Robert', 'last_name' => 'Smith'}])
  end
  it %q(lets you chain expressions) do
    expect(subject.exclude('first_name' => %w(John Mary)).subsume('last_name' => 'Smith')).to eq([{'first_name' => 'Pamela', 'last_name' => 'Smith'},
                                                                                                  {'first_name' => 'Robert', 'last_name' => 'Smith'}])
    expect(subject.subsume('last_name' => 'Smith').exclude('first_name' => %w(John Mary))).to eq([{'first_name' => 'Pamela', 'last_name' => 'Smith'},
                                                                                                  {'first_name' => 'Robert', 'last_name' => 'Smith'}])
  end

end