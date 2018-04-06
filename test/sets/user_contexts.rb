module Contexts
  module UserContexts
    def create_users
      @alec = User.create(first_name: "Alec", last_name: "Lam", andrew_id: "ahlam", email: "ahlam@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "Player", active: true, year: "Junior")
      @greg = User.create(first_name: "Greg", last_name: "Bellwoar", andrew_id: "gbellwoa", email: "gbellwoa@andrew.cmu.edu", major: "Business", phone: "1111111111", role: "Player", active: true, year: "Junior")
      @zack = User.create(first_name: "Zack", last_name: "Masciopinto", andrew_id: "zpm", email: "zpm@andrew.cmu.edu", major: "Engineering", phone: "1111111111", role: "Player", active: true, year: "Junior")
      @sam = User.create(first_name: "Sam", last_name: "Fazel", andrew_id: "sfazelsa", email: "sfazelsa@andrew.cmu.edu", major: "Engineering", phone: "1111111111", role: "Player", active: true, year: "Junior")


      @jack = User.create(first_name: "Jack", last_name: "McCambridge", andrew_id: "jmccambridge", email: "jmccambridge@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
      @phil = User.create(first_name: "Phil", last_name: "Petrakian", andrew_id: "ppetrakian", email: "ppetrakian@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
      @jamie = User.create(first_name: "Jamie", last_name: "Wheaton", andrew_id: "jwheaton", email: "jwheaton@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
      @mike = User.create(first_name: "Mike", last_name: "Lin", andrew_id: "mlin", email: "mlin@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
      @anthony = User.create(first_name: "Anthony", last_name: "Gulli", andrew_id: "agulli", email: "agulli@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
      @jacob = User.create(first_name: "Jacob", last_name: "Moscowitz", andrew_id: "jmoscowitz", email: "jmoscowitz@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
      @jack = User.create(first_name: "Jack", last_name: "Painter", andrew_id: "jpainter", email: "jpainter@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
      @alex = User.create(first_name: "Alex", last_name: "Dziadosz", andrew_id: "adziadosz", email: "adziadosz@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
      @chris = User.create(first_name: "Chris", last_name: "Harla", andrew_id: "charla", email: "charla@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
      @cooper = User.create(first_name: "Cooper", last_name: "Tubiana", andrew_id: "ctubiana", email: "ctubiana@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
      @elliot = User.create(first_name: "Elliot", last_name: "Cohen", andrew_id: "ecohen", email: "ecohen@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
      @nicolas = User.create(first_name: "Nicolas", last_name: "Poveda", andrew_id: "npoveda", email: "npoveda@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
      @charlie = User.create(first_name: "Charle", last_name: "Meacham", andrew_id: "cmeacham", email: "cmeacham@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
      @alex = User.create(first_name: "Alex", last_name: "Singh", andrew_id: "asingh", email: "asingh@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
      @nick = User.create(first_name: "Nick", last_name: "Ishim", andrew_id: "nishim", email: "nishim@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
      @ben = User.create(first_name: "Ben", last_name: "Neyer", andrew_id: "bneyer", email: "bneyer@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
      @bencapeloto = User.create(first_name: "Ben", last_name: "Capeloto", andrew_id: "bcapeloto", email: "bcapeloto@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
      @jordi = User.create(first_name: "Jordi", last_name: "Long", andrew_id: "jlong", email: "jlong@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
      @reed = User.create(first_name: "Reed", last_name: "Peterson", andrew_id: "rpeterson", email: "rpeterson@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
      @sam = User.create(first_name: "Sam", last_name: "Adida", andrew_id: "sadida", email: "sadida@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
      @patrick = User.create(first_name: "Patrick", last_name: "Kollman", andrew_id: "pkollman", email: "pkollman@andrew.cmu.edu", major: "Information Systems", phone: "1111111111", role: "player", active: true, year: "Junior")
    end

    def delete_users
      @alec.delete
      @greg.delete
      @zack.delete
      @sam.delete
      @jack.delete
      @phil.delete
      @jamie.delete
      @mike.delete
      @anthony.delete
      @jacob.delete
      @jack.delete
      @alex.delete
      @chris.delete
      @cooper.delete
      @elliot.delete
      @nicolas.delete
      @charlie.delete
      @alex.delete
      @nick.delete
      @ben.delete
      @bencapeloto.delete
      @jordi.delete
      @reed.delete
      @sam.delete
      @patrick.delete
    end
  end
end
