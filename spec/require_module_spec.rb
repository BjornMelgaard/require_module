require_relative 'spec_helper'

def unload_all_matching(regex)
  Object.constants.grep(regex).each do |const|
    Object.send(:remove_const, const)
  end
end

describe 'require_module_relative' do
  before do
    unload_all_matching(/FixturesSomeLib/)
  end

  context 'require_module_relative' do
    it 'without ext' do
      mod = require_module_relative './fixtures/some_lib'

      expect(mod.inspect).to end_with 'FixturesSomeLib'
      expect(mod.some_fn).to eq 'some_val'
    end

    it 'with ext' do
      mod = require_module_relative './fixtures/some_lib.rb'

      expect(mod.inspect).to end_with 'FixturesSomeLib'
      expect(mod.some_fn).to eq 'some_val'
    end

    it 'pathname without ext' do
      mod = require_module_relative(Pathname.new('./fixtures/some_lib'))

      expect(mod.inspect).to end_with 'FixturesSomeLib'
      expect(mod.some_fn).to eq 'some_val'
    end

    it 'pathname with ext' do
      mod = require_module_relative(Pathname.new('./fixtures/some_lib.rb'))

      expect(mod.inspect).to end_with 'FixturesSomeLib'
      expect(mod.some_fn).to eq 'some_val'
    end

    it "raises NameError if dependencies can't be resolved" do
      expect do
        require_module_relative './unresolveable'
      end.to raise_error(LoadError)
    end
  end

  context 'require_module' do
    it 'without ext' do
      mod = require_module(File.dirname(__FILE__) + '/fixtures/some_lib')

      expect(mod.inspect).to end_with 'FixturesSomeLib'
      expect(mod.some_fn).to eq 'some_val'
    end

    it 'with ext' do
      mod = require_module(File.dirname(__FILE__) + '/fixtures/some_lib.rb')

      expect(mod.inspect).to end_with 'FixturesSomeLib'
      expect(mod.some_fn).to eq 'some_val'
    end

    it 'pathname without ext' do
      mod = require_module(Pathname.new(File.dirname(__FILE__) + '/fixtures/some_lib'))

      expect(mod.inspect).to end_with 'FixturesSomeLib'
      expect(mod.some_fn).to eq 'some_val'
    end

    it 'pathname with ext' do
      mod = require_module(Pathname.new(File.dirname(__FILE__) + '/fixtures/some_lib.rb'))

      expect(mod.inspect).to end_with 'FixturesSomeLib'
      expect(mod.some_fn).to eq 'some_val'
    end

    it "raises NameError if dependencies can't be resolved" do
      expect do
        require_module './unresolveable'
      end.to raise_error(LoadError)
    end
  end

  context 'test cache' do
    it 'test with cache' do
      mod = require_module_relative './fixtures/some_lib'
      mod2 = require_module_relative './fixtures/some_lib'

      expect(mod.inspect).to end_with 'FixturesSomeLib'
      expect(mod2.inspect).to end_with 'FixturesSomeLib'

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
end
