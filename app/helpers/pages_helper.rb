module Merb
  module PagesHelper
    def sexify(object, form_definition = {})
      f = "\n"
      object.class.properties.each do |pr|
        t = DataMapper::Types
        if pr.type.is_a?(t::Boolean) || pr.type.is_a?(TrueClass)
          f << nl(label(:"#{pr.name}"))
          f << nl(check_box(:"#{pr.name}"))
        elsif [String, Float, Fixnum, Integer, BigDecimal].include?(pr.type)
          f << nl(label(:"#{pr.name}"))
          f << nl(text_field(:"#{pr.name}"))
        elsif pr.type == t::Text
          f << nl(label( :"#{pr.name}" ))
          f << nl(text_area(:"#{pr.name}"))
        elsif pr.type.is_a?(Date)
          dater = "\n"
          f << tag(:label, :class => :date) do
            yearc = (Time.now.year-100..Time.now.year)
            dater << select(:"#{pr.name}_month", :collection => (1..12).to_a); dater << " / "
            dater << select(:"#{pr.name}_day" , :collection => (1..31).to_a);  dater << " / "
            dater << select(:"#{pr.name}_year" , :collection => (yearc).to_a); dater << " / "
            dater
          end
        end
      end
      f
    end
    def hy_guess_type(object)
      object.class.properties.each do |pr|
        t = DataMapper::Types
        inputs = {}
        inputs[:"#{pr.name}"] = if pr.type.is_a?(t::Boolean) ||
            pr.type.is_a?(TrueClass); :check_box
        elsif [String, Float, Fixnum,
            Integer, BigDecimal,
            ].include?(pr.type);      :text_field
        elsif pr.type == t::Text;     :text_area
        elsif pr.type.is_a?(Date);    :date
        end
        inputs
      end
    end
    # This function returns its arguments with new lines
    def nl(arg)
      tag(:div, "\n  #{arg}\n")
    end
  end
end # Merb
