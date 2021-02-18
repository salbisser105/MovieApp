class Cast {

  List<Actor> actors = new List();

  Cast.fromJsonList(List<dynamic> jsonList){
    if (jsonList== null) return;

    jsonList.forEach((element) { 
      final actor = Actor.fromJsonMap(element);
      actors.add(actor);
    
    });
  }

}


class Actor {
  int id;
  String name;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String job;

  Actor({
    this.id,
    this.name,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.job,
  });

  Actor.fromJsonMap (Map <String, dynamic> json ) {

    id           = json['id'];
    name         = json['name']; 
    popularity   = json['popularity'];
    profilePath  = json['profile_path'];
    castId       = json['cast_id'];
    character    = json['character'];
    creditId     = json['credit_id'];
    order        = json['order'];
    job          = json['job'];

  }

 getPhoto(){

    if ( profilePath == null ) {
      return 'https://iupac.org/wp-content/uploads/2018/05/default-avatar.png';
    }else {
     return 'https://image.tmdb.org/t/p/original/$profilePath';
     
    }
     
    
  }

}
