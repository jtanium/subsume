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
    expect(subject.filter('first_name' => 'John')).to eq([{'first_name' => 'John', 'last_name' => 'Smith'},
                                                          {'first_name' => 'John', 'last_name' => 'Lack'},
                                                          {'first_name' => 'John', 'last_name' => 'Morehouse'}])
  end
  it %q(lets you select hashes by multiple values) do
    expect(subject.filter('first_name' => %w(Robert Pamela))).to eq([{'first_name' => 'Robert', 'last_name' => 'Morehouse'},
                                                                     {'first_name' => 'Pamela', 'last_name' => 'Smith'},
                                                                     {'first_name' => 'Robert', 'last_name' => 'Smith'}])
  end
  it %q(lets you select hashes by multiple keys) do
    expect(subject.filter('first_name' => 'John', 'last_name' => 'Smith')).to eq([{'first_name' => 'John', 'last_name' => 'Smith'}])

    expect(subject.filter('first_name' => %w(Robert Pamela), 'last_name' => 'Smith')).to eq([{'first_name' => 'Pamela', 'last_name' => 'Smith'},
                                                                                             {'first_name' => 'Robert', 'last_name' => 'Smith'}])
  end
  it %q(lets you exclude hashes by a single value) do
    expect(subject.sift('first_name' => 'John')).to eq([{'first_name' => 'Robert', 'last_name' => 'Morehouse'},
                                                        {'first_name' => 'Mary', 'last_name' => 'Greer'},
                                                        {'first_name' => 'Pamela', 'last_name' => 'Smith'},
                                                        {'first_name' => 'Mary', 'last_name' => 'Lack'},
                                                        {'first_name' => 'Robert', 'last_name' => 'Smith'},
                                                        {'first_name' => 'Mary', 'last_name' => 'Smith'}])
  end
  it %q(lets you exclude hashes by multiple values) do
    expect(subject.sift('first_name' => %w(John Mary))).to eq([{'first_name' => 'Robert', 'last_name' => 'Morehouse'},
                                                               {'first_name' => 'Pamela', 'last_name' => 'Smith'},
                                                               {'first_name' => 'Robert', 'last_name' => 'Smith'}])
  end
  it %q(lets you chain expressions) do
    expect(subject.sift('first_name' => %w(John Mary)).filter('last_name' => 'Smith')).to eq([{'first_name' => 'Pamela', 'last_name' => 'Smith'},
                                                                                              {'first_name' => 'Robert', 'last_name' => 'Smith'}])
    expect(subject.filter('last_name' => 'Smith').sift('first_name' => %w(John Mary))).to eq([{'first_name' => 'Pamela', 'last_name' => 'Smith'},
                                                                                              {'first_name' => 'Robert', 'last_name' => 'Smith'}])
  end
end