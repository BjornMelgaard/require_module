require_relative 'spec_helper'

describe 'include_relative' do
  it 'without ext' do
    klass = Class.new.class_exec do
      include_relative './fixtures/root_level_funcs', binding
    end
    p klass

    expect(klass.some_fn).to eq 'some_val'
  end

  it 'with ext' do
    klass = Class.new.class_exec do
      include_relative './fixtures/root_level_funcs.rb', binding
    end

    expect(klass.some_fn).to eq 'some_val'
  end

  it "raises NameError if dependencies can't be resolved" do
    expect do
      include_relative './unresolveable', binding
    end.to raise_error(LoadError)
  end
end
