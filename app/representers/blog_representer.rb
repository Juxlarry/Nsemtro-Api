class BlogRepresenter 
    def initialize(blog)
        @blog = blog
    end 

    def as_json 
        {
            id: blog.id, 
            title: blog.title,
            content: blog.content,
            author: blog.author, 
            category: Category.find(blog.id).name, 
            posted_on: blog.created_at
        }
    end 

    private 

    attr_reader :blog
end 