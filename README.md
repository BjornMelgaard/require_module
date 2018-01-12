# require_module

Evaluates file content inside Module.new, with cache

# API
`require_module(fullpath)`

`require_module_relative(relative_path)`

# Example
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
