require_relative 'core_extensions/array'
require_relative 'core_extensions/class'
require_relative 'core_extensions/hash'
require_relative 'core_extensions/object'
require_relative 'core_extensions/symbol'
require_relative 'core_extensions/string'
require_relative 'core_extensions/nil_class'
require_relative 'core_extensions/true_class'
require_relative 'core_extensions/false_class'

module Contractinator
  ::Object.include(CoreExtensions::Object)

  ::Array.include(CoreExtensions::Array)
  ::Class.include(CoreExtensions::Class)
  ::Hash.include(CoreExtensions::Hash)
  ::String.include(CoreExtensions::String)
  ::Symbol.include(CoreExtensions::Symbol)
  ::NilClass.include(CoreExtensions::NilClass)
  ::TrueClass.include(CoreExtensions::TrueClass)
  ::FalseClass.include(CoreExtensions::FalseClass)
end
