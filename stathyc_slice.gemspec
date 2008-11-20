# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{stathyc_slice}
  s.version = "1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Othmane Benkirane (rhyhann)"]
  s.date = %q{2008-11-20}
  s.description = %q{Merb Slice that provides core static pages functionnalities}
  s.email = %q{eo-in-rhyhann-net}
  s.extra_rdoc_files = ["README.markdown", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README.markdown", "Rakefile", "TODO", "lib/static_slice.rb", "lib/static_slice", "lib/static_slice/slicetasks.rb", "lib/static_slice/merbtasks.rb", "lib/static_slice/spectasks.rb", "spec/models", "spec/models/page_spec.rb", "spec/requests", "spec/requests/pages_spec.rb", "spec/controllers", "spec/controllers/main_spec.rb", "spec/spec_helper.rb", "spec/static_slice_spec.rb", "app/models", "app/models/page.rb", "app/views", "app/views/layout", "app/views/layout/static_slice.html.haml", "app/views/pages", "app/views/pages/new.html.haml", "app/views/pages/edit.html.haml", "app/views/pages/delete.html.haml", "app/views/pages/_sidebar.html.haml", "app/views/pages/show.html.haml", "app/views/pages/index.html.haml", "app/views/main", "app/views/main/index.html.erb", "app/helpers", "app/helpers/pages_helper.rb", "app/helpers/application_helper.rb", "app/controllers", "app/controllers/application.rb", "app/controllers/pages.rb", "app/controllers/main.rb", "public/images", "public/images/css", "public/images/css/bg02-right.png", "public/images/css/bg02-blue-right.png", "public/images/css/bg02-blue-left.png", "public/images/css/bg.png", "public/images/css/banner_mountains.jpg", "public/images/css/menuleft.png", "public/images/css/menuright.png", "public/images/css/bg02-white-right.png", "public/images/css/menu.png", "public/images/css/bg02-left.png", "public/images/css/bg02-white-left.png", "public/images/css/logo.png", "public/javascripts", "public/javascripts/master.js", "public/stylesheets", "public/stylesheets/master.css", "stubs/app", "stubs/app/controllers", "stubs/app/controllers/application.rb", "stubs/app/controllers/main.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/rhyhann/merb-stathyc_slice}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{merb}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Merb Slice that provides core static pages functionnalities}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<merb-slices>, [">= 1.0"])
    else
      s.add_dependency(%q<merb-slices>, [">= 1.0"])
    end
  else
    s.add_dependency(%q<merb-slices>, [">= 1.0"])
  end
end
