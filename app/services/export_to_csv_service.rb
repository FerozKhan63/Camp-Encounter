require 'csv'

class ExportToCsvService
  def initialize(klass)
    @klass = klass
  end

  def call
    CSV.generate(headers: true) do |csv|
      csv << @klass.attributes
      @klass.all.each do |u|
        csv << @klass.attributes.map{ |attr| u.send(attr) }
      end
    end
  end
end
