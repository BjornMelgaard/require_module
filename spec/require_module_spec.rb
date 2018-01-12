require_relative 'spec_helper'

def unload_all
  %w[UsrSrcAppSpecFixturesSomeLib].each do |const|
    begin
      Object.send(:remove_const, const)
    rescue StandardError
      nil
    end
  end
end

describe 'require_module_relative' do
  before do
    unload_all
  end

  it 'without ext' do
    mod = require_module_relative './fixtures/some_lib'

    expect(mod.inspect).to eq 'UsrSrcAppSpecFixturesSomeLib'
    expect(mod.some_fn).to eq 'some_val'
  end

  it 'with ext' do
    mod = require_module_relative './fixtures/some_lib.rb'

    expect(mod.inspect).to eq 'UsrSrcAppSpecFixturesSomeLib'
    expect(mod.some_fn).to eq 'some_val'
  end

  it "raises NameError if dependencies can't be resolved" do
    expect do
      require_module_relative './unresolveable'
    end.to raise_error(LoadError)
  end

  it 'test cache' do
    mod = require_module_relative './fixtures/some_lib'
    mod2 = require_module_relative './fixtures/some_lib'

    expect(mod.inspect).to eq 'UsrSrcAppSpecFixturesSomeLib'
    expect(mod2.inspect).to eq 'UsrSrcAppSpecFixturesSomeLib'

    expect(mod <=> mod2).to eq 0
  end

  it 'test without cache' do
    mod = require_module_relative('./fixtures/some_lib.rb', cache: false)

    expect(mod.inspect).to start_with '#<Module:'
    expect(mod.some_fn).to eq 'some_val'
  end

  it 'test without cache and ext' do
    mod = require_module_relative('./fixtures/some_lib', cache: false)

    expect(mod.inspect).to start_with '#<Module:'
    expect(mod.some_fn).to eq 'some_val'
  end
end
