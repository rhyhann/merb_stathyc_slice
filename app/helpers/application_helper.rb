module Merb
  module StaticSlice
    module ApplicationHelper
      
      # @param *segments<Array[#to_s]> Path segments to append.
      #
      # @return <String> 
      #  A path relative to the public directory, with added segments.
      def image_path(*segments)
        public_path_for(:image, *segments)
      end
      
      # @param *segments<Array[#to_s]> Path segments to append.
      #
      # @return <String> 
      #  A path relative to the public directory, with added segments.
      def javascript_path(*segments)
        public_path_for(:javascript, *segments)
      end
      
      # @param *segments<Array[#to_s]> Path segments to append.
      #
      # @return <String> 
      #  A path relative to the public directory, with added segments.
      def stylesheet_path(*segments)
        public_path_for(:stylesheet, *segments)
      end
      
      # Construct a path relative to the public directory
      # 
      # @param <Symbol> The type of component.
      # @param *segments<Array[#to_s]> Path segments to append.
      #
      # @return <String> 
      #  A path relative to the public directory, with added segments.
      def public_path_for(type, *segments)
        ::StaticSlice.public_path_for(type, *segments)
      end
      
      # Construct an app-level path.
      # 
      # @param <Symbol> The type of component.
      # @param *segments<Array[#to_s]> Path segments to append.
      #
      # @return <String> 
      #  A path within the host application, with added segments.
      def app_path_for(type, *segments)
        ::StaticSlice.app_path_for(type, *segments)
      end
      
      # Construct a slice-level path.
      # 
      # @param <Symbol> The type of component.
      # @param *segments<Array[#to_s]> Path segments to append.
      #
      # @return <String> 
      #  A path within the slice source (Gem), with added segments.
      def slice_path_for(type, *segments)
        ::StaticSlice.slice_path_for(type, *segments)
      end



      # This function takes the Model.sexhy hash and guesses the untyped variables, sorts it
      # and then returns the incredible formù!
      def sexify(object, f_d = {:properties => {}})
        f = ''
        f_d = object_labels(object, object_types(object))
        f_d[:properties].delete_if {|k,v| [:id,:created_at,:updated_at].include?(k)}
        f_d[:properties].to_a.sort_by {|a|a[1][:order]}.each do |element|
          type, options = element[0], element[1]
          # TODO: default hashes
          html = object.class.sexhy[:html]
          f << nl(open_tag(:div))
          f << nl(html[:label][:tag],
                  options[:label],
                  html[:label][:attributes].merge(
                      {:for => "#{object.class.to_s.downcase}_#{type.to_s}"}
                    )
                 )
          eval "f << nl(html[:input][:tag],
                        (#{options[:input]}(:#{type})).to_s,
                        html[:input][:attributes]
                       )"
          f << nl(close_tag(:div))
        end
        f
      end
      def order(hash)
        n = 0
        hash[:properties].each do |k,v|
          n+=1
          hash[:properties][k][:order] = n if hash[:properties][k][:order].nil?
        end
        hash
      end
      # This function returns the list of the inputs.
      # It will first try to merge it to the given hash, then to the model's hash
      # then to nothing.
      def object_types(o, c_d = {:properties => {}})
        c_d = o.class.sexhy if c_d == {:properties => {}} && o.class.methods.include?('sexhy')
        c_d = order c_d
        properties = {}
        o.class.properties.each do |pr|
          t = DataMapper::Types
          properties[pr.name] = {}
          properties[pr.name][:input] = if pr.type.is_a?(t::Boolean) ||
              pr.type.is_a?(TrueClass); 'check_box'
          elsif [String, Float, Fixnum,
              Integer, BigDecimal,
              ].include?(pr.type);      'text_field'
          elsif pr.type == t::Text;     'text_area'
          elsif pr.type.is_a?(Date);    'date'
          end
        end
        c_d[:properties].each {|k,v|
          properties[k].merge!(v)}
        {:properties => properties}
      end
      def object_labels(o, c_d = {:properties => {}})
        c_d = o.class.sexhy if c_d == {} && o.class.methods.include?('sexhy')
        properties = {}
        o.class.properties.each do |pr|
          properties[pr.name] = {}
          properties[pr.name][:label] = pr.name.to_s.capitalize
        end
        c_d[:properties].each {|k,v| properties[k].merge!(v)}
        {:properties => properties}
      end
      # This function returns its arguments with new lines
      def nl(*arg)
        arg[0].is_a?(Symbol) ? nl(tag(*arg)) : "    \n    #{arg[0]}"
      end
    end
  end
end
