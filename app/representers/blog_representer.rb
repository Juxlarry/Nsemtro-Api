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
            posted_on: created_date
        }
    end 

    def created_date
        blog.created_at.strftime('%I:%M %p, %m/%d/%Y')
    end 

    private 

    attr_reader :blog
end 