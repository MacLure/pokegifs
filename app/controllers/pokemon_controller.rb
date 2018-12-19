class PokemonController < ApplicationController

    def show
        res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
        if res.code == 404
            return render :status => 404
        end

        body = JSON.parse(res.body)
        id = body["id"]
        name  = body["name"]
        types = []
        body["types"].each do |type|
            types << type["type"]["name"]
        end

            # redirect_to :status => 404

        res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{name}&rating=g")
        if res.code == 403
            return render :status => 403
        end

        body = JSON.parse(res.body)

        gif_url = body["data"].sample["url"]

        render json: {
            'id' => id,
            'name' => name,
            'types' => types,
            'gif' => gif_url
        }

    end

    def team
        # pokemon_count = HTTParty.get("https://pokeapi.co/api/v2/pokemon/")
        # count_body = JSON.parse(pokemon_count.body)
        # count = count_body["count"]

# -----------
#150 

    output = {}
    incrementor = 1
    6.times do 

        pokemon_api = HTTParty.get("https://pokeapi.co/api/v2/pokemon/#{rand(1..150)}/")
        body = JSON.parse(pokemon_api.body)

        id = body["id"]
        name  = body["name"]
        types = []
        body["types"].each do |type|
            types << type["type"]["name"]
        end

        res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{name}&rating=g")

        body = JSON.parse(res.body)
        gif_url = body["data"].sample["url"]

        output.merge!("pokemon#{incrementor}" =>
            {
                'id' => id,
                'name' => name,
                'types' => types,
                'gif' => gif_url
            })
        incrementor += 1

    end
    render json: { 
        "pokemon" => output
    }


    end

#         pokemon1_api = HTTParty.get("https://pokeapi.co/api/v2/pokemon/#{rand(1..150)}/")
#         body = JSON.parse(pokemon1_api.body)

#         id1 = body["id"]
#         name1  = body["name"]
#         types1 = []
#         body["types"].each do |type|
#             types1 << type["type"]["name"]
#         end

#         res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{name1}&rating=g")
#         if res.code == 403
#             return render :status => 403
#         end

#         body = JSON.parse(res.body)
#         gif_url1 = body["data"].sample["url"]

# #---

#         pokemon2_api = HTTParty.get("https://pokeapi.co/api/v2/pokemon/#{rand(1..count)}/")
#         body = JSON.parse(pokemon2_api.body)
        
#         id2 = body["id"]
#         name2  = body["name"]
#         types2 = []
#         body["types"].each do |type|
#             types2 << type["type"]["name"]
#         end
        
#         res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{name2}&rating=g")
#         if res.code == 403
#             return render :status => 403
#         end
        
#         body = JSON.parse(res.body)
#         gif_url2 = body["data"].sample["url"]

#         render json: { 
#             'pokemon1' => {
#                 'id1' => id1,
#                 'name1' => name1,
#                 'types1' => types1,
#                 'gif1' => gif_url1
#             },
#             'pokemon2' => {
#                 'id2' => id2,
#                 'name2' => name2,
#                 'types2' => types2,
#                 'gif2' => gif_url2
#             }
#         }

# -----------


    end


