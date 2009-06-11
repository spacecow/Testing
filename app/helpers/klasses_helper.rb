module KlassesHelper
  def sort_in_mogi_order array
    (0...array.size).each do |i|
      %w[個別 韓国語 中国語 中級 初級 入門].each do |cat|
        if array.include?( cat )
          array.unshift( array.delete( cat ))
        end
      end
    end
    array
  end
  
  def parse_date s_date
    date = Date.parse( s_date )
    [date.year,"dasan"]
  end
end 