module Contexts
  module UserContexts
    def create_users
      @alec = User.create(first_name: "Alec", last_name: "Lam", andrew_id: "ahlam", email: "ahlam@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
      @greg = User.create(first_name: "Greg", last_name: "Bellwoar", andrew_id: "gbellwoar", email: "gbellwoar@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
      
