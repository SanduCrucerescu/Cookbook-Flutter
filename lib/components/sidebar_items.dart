part of components;

List<Map<String, dynamic>> kSideBarItems = [
  {
    "text": "H o m e",
    "id": 0,
    "image": "assets/images/home.png",
    "onTap": HomePage.id,
    "children": [],
  },
  {
    "text": "M y  P a g e",
    "id": 1,
    "image": "assets/images/ph.png",
    "icon": const Icon(Icons.person),
    "onTap": UserPage.id,
    "children": [
      {
        "text": "F a v o u r i t e s",
        "onTap": FavoritesPage.id,
      },
      {
        "text": "W e e k l y",
        "onTap": WeeklyPage.id,
      },
      {
        "text": "M e s s a g e s",
        "onTap": MessagePage.id,
      },
    ],
  },
  {
    "text": "L o a d i n g",
    "id": 2,
    "onTap": LoadingScreen.id,
    "icon": const Icon(Icons.refresh),
    "children": [],
  },
  {
    "text": "A d d  r e c i p e",
    "id": 3,
    "onTap": AddRecipePage.id,
    "icon": const Icon(Icons.add),
    "children": [],
  },
  {
    "text": "A d m i n",
    "id": 4,
    "onTap": Admin.id,
    "icon": const Icon(Icons.admin_panel_settings),
    "children": [],
  },
  {
    "text": "F A Q",
    "id": 5,
    "onTap": FAQPage.id,
    "icon": const Icon(Icons.help),
    "children": [],
  },
  {
    "text": "ShoppingCart",
    "id": 6,
    "onTap": ShoppingPage.id,
    "icon": const Icon(Icons.abc),
    "children": [],
  },
  {
    "text": "Comments",
    "id": 7,
    "onTap": CommentsPage.id,
    "icon": const Icon(Icons.mode_comment_outlined),
    "children": [],
  }
];
