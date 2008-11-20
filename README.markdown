StaticSlice
===========

A slice for the Merb framework that provides the core static pages functionnalities.
Just see the views for edit.

If you want to protect the CUD actions, you must know that: ALL of them are located in
a content named *for_cud*. simple.

To see all available tasks for StaticSlice run:
> rake -T slices:static_slice

Installation
============

* dependency (config/init.rb)
  > # add the slice as a regular dependency
  > dependency 'static_slice'
* router
  > # example: /static_slice/:controller/:action/:id
  > add_slice(:StaticSlice)
  > # example: /foo/:controller/:action/:id
  > add_slice(:StaticSlice, 'foo') # same as :path => 'foo'
  > # example: /:lang/:controller/:action/:id
  > add_slice(:StaticSlice, :path => ':lang')
  > # example: /:controller/:action/:id
  > slice(:StaticSlice)
* rake
  > rake slices:static_slice:install

Uses
====

You can put your overrides here:
> host-app/slices/static_slice/app - controllers, models, views ...

Templates are located in this order:
1. host-app/slices/static_slice/app/views/*
2. gems/static_slice/app/views/*
3. host-app/app/views/*

You can use the host application's layout by configuring the
static_slice slice in a before_app_loads block:

Merb::Slices.config[:static_slice] = { :layout => :application }

By default :static_slice is used. If you need to override
stylesheets or javascripts, just specify your own files in your layout
instead/in addition to the ones supplied (if any) in 
host-app/public/slices/static_slice.

In any case don't edit those files directly as they may be clobbered any time
rake static_slice:install is run.

About Slices
============

Merb-Slices is a Merb plugin for using and creating application 'slices' which
help you modularize your application. Usually these are reuseable extractions
from your main app. In effect, a Slice is just like a regular Merb MVC
application, both in functionality as well as in structure.

When you generate a Slice stub structure, a module is setup to serve as a
namespace for your controller, models, helpers etc. This ensures maximum
encapsulation. You could say a Slice is a mixture between a Merb plugin (a
Gem) and a Merb application, reaping the benefits of both.

A host application can 'mount' a Slice inside the router, which means you have
full over control how it integrates. By default a Slice's routes are prefixed
by its name (a router :namespace), but you can easily provide your own prefix
or leave it out, mounting it at the root of your url-schema. You can even
mount a Slice multiple times and give extra parameters to customize an
instance's behaviour.

A Slice's Application controller uses controller_for_slice to setup slice
specific behaviour, which mainly affects cascaded view handling. Additionaly,
this method is available to any kind of controller, so it can be used for
Merb Mailer too for example.

There are many ways which let you customize a Slice's functionality and
appearance without ever touching the Gem-level code itself. It's not only easy
to add template/layout overrides, you can also add/modify controllers, models
and other runtime code from within the host application.

To create your own Slice run this (somewhere outside of your merb app):

$ merb-gen slice <your-lowercase-slice-name>
