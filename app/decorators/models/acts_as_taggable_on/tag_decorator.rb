module ActsAsTaggableOn
  class Tag
    def name_and_id
      {id: name, text: name}
    end
  end
end
