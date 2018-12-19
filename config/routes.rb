Rails.application.routes.draw do

  get 'pokemon/team' => 'pokemon#team'

  get 'pokemon/:id' => 'pokemon#show'


end
