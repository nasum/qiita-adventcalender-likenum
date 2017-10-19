class Entry
  def initialize(id: 0,title: "", author: "", like_num: 0, hatebu_num: 0)
    @id = id
    @title = title
    @author = author
    @like_num = like_num
    @hatebu_num = hatebu_num
  end

  def to_csv
    "#{@id},#{@title},#{@author},#{@like_num},#{@hatebu_num}"
  end
end
