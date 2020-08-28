class App.Utils.Autocompletes

    
    @initAllFields: ->
        @_initSearchField()
        @_initFilm()
    
    @_initSearchField: -> 
        $("#search_field").autocomplete(
            source: (request, response)->
                $.ajax(
                    url: "/ac.json",
                    dataType: "json",
                    data: request,
                    success: (data)->
                        if (!data.length) 
                            response([])
                        else 
                            console.log(data)
                            response(data);
                        

                )
            ,
            minLength: 1
        );

    @_initFilm: ->    
        $("#q_film_title_cont").autocomplete(
            source: "/ac.json",
            minLength: 1
        )
