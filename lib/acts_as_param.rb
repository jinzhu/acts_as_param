# ActsAsParam

module ActiveRecord
  module Acts #:nodoc:
    module Param
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def acts_as_param(*fields)
          fields << self.primary_key
          include ActiveRecord::Acts::Param::InstanceMethods
          extend  ActiveRecord::Acts::Param::SingletonMethods

          class_eval <<-EOV
            def self._acts_as_param_fields
              #{fields.inspect}
            end
          EOV
        end
      end

      module SingletonMethods
        def find_by_param(key)
          _acts_as_param_fields.map do |field|
            record = first(:conditions => [ "#{field} = ?", key])
            return record if record.present?
          end
          return nil
        end

        def find_by_param!(key)
          record = find_by_param(key)
          raise ActiveRecord::RecordNotFound unless record
          return record
        end
      end 

      module InstanceMethods
        def to_param
          self.class._acts_as_param_fields.map do |field|
            value = self.send(field.to_sym)
            return value.to_s if value.present?
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::Acts::Param)
