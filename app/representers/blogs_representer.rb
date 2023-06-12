class BlogsRepresenter 
    def initialize(blogs)
        @blogs = blogs
    end 

    def as_json 
        blogs.map do |blog|
            {
                id: blog.id, 
                title: blog.title,
                content: blog.content,
                author: blog.author, 
                category: Category.find(blog.id).name, 
                posted_on: blog.created_at
            }
        end 
    end 

    private 

    attr_reader :blogs
end 