# require_module

[![Build Status](https://travis-ci.org/BjornMelgaard/require_module.svg?branch=master)](https://travis-ci.org/BjornMelgaard/require_module)

Evaluates file content inside Module.new, with cache

# API

## require_module(fullpath)

Evaluates file content inside Module.new and returns new module

```rb
require_module('/home/user/rubyapp/lib', cache: false) # returns #<Module:0000012312>
require_module('/home/user/rubyapp/lib') # returns :HomeUserRubyappLib
```

## require_module_relative(relative_path)

Similar to "require_module", but path is relative to file, where function is executed

Check `lib/require_module.rb` for more


# Example
If you don't want you modules to intersect, they should have unique name.
I was tired of coming up with new names, so created this gem.

Instead of

```rb
# lib.rb
module GloballyUniqueName
  module_function

  def somefn
    'Ima helper'
  end
end
```

```rb
# consumer.rb
require_relative './lib'

module Consumer
  include GloballyUniqueName

  def foo
    somefn == 'Ima helper'
  end
end
```

You can write this

```rb
# lib.rb
module_function

def somefn
  'Ima helper'
end
```

```rb
# consumer.rb
module Consumer
  include require_module_relative('./lib')

  def foo
    somefn == 'Ima helper'
  end
end
```
