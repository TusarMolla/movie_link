
import 'package:movie_link/models/category.dart';
import 'package:movie_link/models/movie.dart';

class DummyData {
  static List<Movie> get imageList => [
    Movie(
        imageLink:"https://media.istockphoto.com/photos/movie-projector-on-dark-background-picture-id1007557230?k=20&m=1007557230&s=612x612&w=0&h=hWEw8rA6ASt-Z18pNvUKk2GtQZVLj1GHv3HFlNB4p6U=",
        category: "Test Category",
        movieLink: "text",
        duration: "1.5 Hours",
        ratting: "4.5",
        title: "New Movie Title"
    ),
    Movie(
        imageLink:"https://media.istockphoto.com/photos/happy-latin-american-couple-at-the-movies-picture-id688782978?k=20&m=688782978&s=612x612&w=0&h=ZG0SNY4lRsw3WsQEKOJ2DoX03vFDTjRwon6ZtMytmd4=",

        category: "Test Category",
        movieLink: "text",
        duration: "1.5 Hours",
        ratting: "4.5",
        title: "New Movie Title"
    ),
    Movie(
        imageLink: "https://media.istockphoto.com/photos/popcorn-and-clapperboard-picture-id1191001701?k=20&m=1191001701&s=612x612&w=0&h=uDszifNzvgeY5QrPwWvocFOUCw8ugViuw-U8LCJ1wu8=",
        category: "Test Category",
        movieLink: "text",
        duration: "1.5 Hours",
        ratting: "4.5",
      title: "New Movie Title"

    ),
    Movie(
        imageLink: "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/c618cd88432989.5dd5e72e505d1.jpg",
        category: "Love",
        movieLink: "text",
        duration: "1.5 Hours",
        ratting: "4.5",
      title: "Seven"

    ),
    Movie(
        imageLink: "http://www.impawards.com/2022/posters/uncharted_ver2.jpg",
        category: "Love",
        movieLink: "text",
        duration: "1.5 Hours",
        ratting: "4.5",
        title: "Uncharted"

    ),
      ];

  static List<CategoryModel> get categoryList=>[
    CategoryModel(title: "Action Movie",image:"https://media.comicbook.com/wp-content/uploads/2013/01/oscars-best-action-movie-202x300.jpg" ),
    CategoryModel(title:"Comedy Movies" ,image:"https://www.popoptiq.com/wp-content/uploads/2022/05/filming-comedy-film-05252022-720x540.jpg.webp" ),
    CategoryModel(title: "Action Movie",image:"https://media.comicbook.com/wp-content/uploads/2013/01/oscars-best-action-movie-202x300.jpg" ),
    CategoryModel(title:"Comedy Movies" ,image:"https://www.popoptiq.com/wp-content/uploads/2022/05/filming-comedy-film-05252022-720x540.jpg.webp" ),
    CategoryModel(title: "Action Movie",image:"https://media.comicbook.com/wp-content/uploads/2013/01/oscars-best-action-movie-202x300.jpg" ),
    CategoryModel(title:"Comedy Movies" ,image:"https://www.popoptiq.com/wp-content/uploads/2022/05/filming-comedy-film-05252022-720x540.jpg.webp" ),
    CategoryModel(title: "Action Movie",image:"https://media.comicbook.com/wp-content/uploads/2013/01/oscars-best-action-movie-202x300.jpg" ),
    CategoryModel(title:"Comedy Movies" ,image:"https://www.popoptiq.com/wp-content/uploads/2022/05/filming-comedy-film-05252022-720x540.jpg.webp" ),

  ];
}
