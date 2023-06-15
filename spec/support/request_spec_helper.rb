module RequestSpecHelper 
    def json 
        JSON.parse(response.body)
    end 

    def login(user) 
        post '/login', params: {
            user: {
                email: user.email, 
                password: user.password
            }
        }
    end  
end