part of components;

List<Map<String, dynamic>> kSideBarItems = [
  {
    "text": "H o m e",
    "image": "assets/images/home.png",
    "onTap": HomePage.id,
    "children": [],
  },
  {
    "text": "M y  P a g e",
    "image": "assets/images/ph.png",
    "onTap": HomePage.id,
    "children": [
      {
        "text": "F a v o u r i t e s",
        "onTap": HomePage.id,
      },
      {
        "text": "W e e k l y",
        "onTap": HomePage.id,
      }
    ],
  },
  // {
  //   "text": "W e e k l y",
  //   "image": "assets/images/weekly.png",
  //   "onTap": HomePage.id,
  //   "children": [],
  // },
  // {
  //   "text": "F a v o u r i t e s",
  //   "image": "assets/images/starWhite.png",
  //   "onTap": HomePage.id,
  //   "children": [],
  // },
  {
    "text": "A d m i n",
    "image": "assets/images/starFilled.png",
    "onTap": Admin.id,
    "children": [],
  },
  {
    "text": "F A Q",
    "image": "assets/images/starFilled.png",
    "onTap": FAQPage.id,
    "children": [],
  }
];
