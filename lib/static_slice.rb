if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)

  load_dependency 'merb-slices'
  Merb::Plugins.add_rakefiles "static_slice/merbtasks", "static_slice/slicetasks", "static_slice/spectasks"

  # Register the Slice for the current host application
  Merb::Slices::register(__FILE__)
  
  # Slice configuration - set this in a before_app_loads callback.
  # By default a Slice uses its own layout, so you can swicht to 
  # the main application layout or no layout at all if needed.
  # 
  # Configuration options:
  # :layout - the layout to use; defaults to :static_slice
  # :mirror - which path component types to use on copy operations; defaults to all
  Merb::Slices::config[:static_slice][:layout] ||= :static_slice
  
  # All Slice code is expected to be namespaced inside a module
  module StaticSlice
    
    # Slice metadata
    self.description = "StathycSlice provides core static pages functionnalities, with CUD operations separated, so you can easily protect your app."
    self.version = "0.1"
    self.author = "(rhyhann, Othmane Benkirane)"
    
    # Stub classes loaded hook - runs before LoadClasses BootLoader
    # right after a slice's classes have been loaded internally.
    def self.loaded
    end
    
    # Initialization hook - runs before AfterAppLoads BootLoader
    def self.init
    end
    
    # Activation hook - runs after AfterAppLoads BootLoader
    def self.activate
    end
    
    # Deactivation hook - triggered by Merb::Slices.deactivate(StaticSlice)
    def self.deactivate
    end
    
    # Setup routes inside the host application
    #
    # @param scope<Merb::Router::Behaviour>
    #  Routes will be added within this scope (namespace). In fact, any 
    #  router behaviour is a valid namespace, so you can attach
    #  routes at any level of your router setup.
    #
    # @note prefix your named routes with :static_slice_
    #   to avoid potential conflicts with global named routes.
    def self.setup_router(scope)
      # example of a named route

      scope.resources :pages
      # http://eo:4000/pages
      scope.match('/index(.:format)').to(:controller => 'pages', :action => 'index').name(:index)
      # the slice is mounted at /static_slice - note that it comes before default_routes
      scope.match('/').to(:controller => 'pages', :action => 'index').name(:home)
      # enable slice-level default routes by default
      scope.default_routes
    end
    
  end
  
  # Setup the slice layout for StaticSlice
  #
  # Use StaticSlice.push_path and StaticSlice.push_app_path
  # to set paths to static_slice-level and app-level paths. Example:
  #
  # StaticSlice.push_path(:application, StaticSlice.root)
  # StaticSlice.push_app_path(:application, Merb.root / 'slices' / 'static_slice')
  # ...
  #
  # Any component path that hasn't been set will default to StaticSlice.root
  #
  # Or just call setup_default_structure! to setup a basic Merb MVC structure.
  StaticSlice.setup_default_structure!
  
  # Add dependencies for other StaticSlice classes below. Example:
  # dependency "static_slice/other"
  
end
