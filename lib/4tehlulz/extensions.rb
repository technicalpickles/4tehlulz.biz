Joint::AttachmentProxy.class_eval do
  def each
    while buf = read(8192)
      yield buf
    end
  end
end


