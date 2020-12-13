import 'food_model.dart';

List<FoodItemModel> foodList = [
  /// cooked food
  FoodItemModel(
    foodName: 'Fried Rice',
    price: 500,
    description:
        'Fried rice is a dish of cooked rice that has been stir-fried in a wok '
        'or a frying pan and is usually mixed with other ingredients such as eggs,'
        ' vegetables, seafood, or meat. It is often eaten by itself or as an '
        'accompaniment to another dish. Fried rice is a popular component of'
        ' East Asian, Southeast Asian and certain South Asian cuisines. As '
        'a homemade dish, fried rice is typically made with ingredients left '
        'over from other dishes, leading to countless variations. Fried rice '
        'first developed during the Sui Dynasty in China and as such all fried '
        'rice dishes can trace their origins to Chinese fried rice.',
    rating: 4.5,
    foodType: FoodTypeEnum.CookedFood,
    imageUrl:
        'https://cheflolaskitchen.com/wp-content/uploads/2015/06/Fried-Rice-20.jpg.webp',
  ),
  FoodItemModel(
    foodName: "Jollof rice",
    price: 500,
    description:
        "Jollof rice traditionally consists of rice, cooking oil, vegetables "
        "such as tomato, onion, red pepper, garlic, ginger and scotch bonnet."
        " To enhance the colour of the dish, tomato paste (purée) is added."
        " As seasoning spices, salt, seasoning/stock cubes (a blend of flavour "
        "enhancers, salt, nutmeg and herbs), curry powder and dried thyme are "
        "used. To complement the dish, chicken, turkey, beef or fish are "
        "often served with the dish.",
    rating: 4.5,
    foodType: FoodTypeEnum.CookedFood,
    imageUrl:
        "https://www.africanbites.com/wp-content/uploads/2014/03/IMG_0422.jpg",
  ),
  FoodItemModel(
    foodName: 'Coconut rice',
    price: 500,
    description:
        "Coconut rice is a dish prepared by soaking white rice in coconut"
        " milk or cooking it with coconut flakes. As both the coconut and the"
        " rice-plant are commonly found in the tropics all-around the world, "
        "coconut rice too is found in many cultures throughout the world, "
        "spanning across the equator from the Indian subcontinent, Southeast Asia, "
        "South America, Central America, East Africa, and Caribbean. \n In Nigeria, "
        "coconut rice is made by cooking rice in the juice of shredded coconut "
        "flesh. The shredded coconut flesh is steeped in hot water and then "
        "drained to give 'milk.' The milk can be added to a tomato base, such "
        "as that used for jollof rice, or cooked on its own with the rice.",
    rating: 4.5,
    foodType: FoodTypeEnum.CookedFood,
    imageUrl: "https://i.ytimg.com/vi/uT7v8mp1XRg/hqdefault.jpg",
  ),
  FoodItemModel(
    foodName: "Banga Rice",
    price: 500,
    description: "Banga Rice is a traditional Nigerian food prepared with palm "
        "fruit like in palm nut soup. It is widely known in the southern and "
        "eastern parts of Nigeria. A food commonly eating by the Urhobo, Isoko, "
        "and the Igbo people. Banga is the oil or juice extracted from palm nut "
        "fruit. It is called Banga rice after the juice extracted from the palm"
        " nut is cooked together with parboiled white rice. There are two ways "
        "of preparing Banga rice. The Igbo people version and the Urhobo/Isoko people version. The Urhobo/Isoko people add special spices such as; Taiko, Benetientien, and Rogoje to their Banga soup. In contrast, the Igbo people do not use these special spices in preparing theirs.",
    rating: 4.5,
    foodType: FoodTypeEnum.CookedFood,
    imageUrl:
        "https://justnativefoods.ng/wp-content/uploads/2020/05/banga-rice.jpg",
  ),
  FoodItemModel(
    foodName: "Rice And Beef Stew",
    price: 500,
    description: "Plain white rice served with stew, plantain and beef only.",
    rating: 4.5,
    foodType: FoodTypeEnum.CookedFood,
    imageUrl:
        "https://storage.dado.ng/wp-content/uploads/2018/11/06200125/1527927368.jpg",
  ),
  FoodItemModel(
    foodName: "Ewa Aganyin",
    price: 500,
    description:
        "Ewa Aganyin (also spelled incorrectly as Ewa Agoyin) is a street food (also eaten as a meal in many Yoruba households) commonly eaten across Nigeria. The beans are made to be extremely soft or mashed. It is commonly eaten with barely ground pepper and tomato sauce which is very spicy, but peppery. It has a local name of 'Ewa G'. Additional ingredients can include palm oil, onion and crayfish. It is commonly eaten with bread, which makes it very satisfying. A common slang is 'ewa G go block belle', meaning ewa aganyin will fill your stomach. It is a popular food for Nigerians as it is both delicious and very filling.",
    rating: 4.5,
    foodType: FoodTypeEnum.CookedFood,
    imageUrl:
        "https://i0.wp.com/chefcinokitchen.com/wp-content/uploads/2020/04/beans-with-fried-plantain.jpg?fit=828%2C796&ssl=1",
  ),
  FoodItemModel(
    foodName: "Plantain Frittata",
    price: 500,
    description:
        "Plantain Frittata is a delicious breakfast of plantain and eggs cooked slightly different. It’s so easy to make yet so tasty. My perfect Sunday morning breakfast.",
    rating: 4.5,
    foodType: FoodTypeEnum.CookedFood,
    imageUrl:
        "https://guardian.ng/wp-content/uploads/2017/11/Fried-Plantain-Frittata-2-e1510306800913.jpg",
  ),
  FoodItemModel(
      foodName: "Spaghetti and meatballs",
      price: 500,
      description:
          "Spaghetti and meatballs or spaghetti with meatballs is an Italian-American dish consisting of spaghetti, tomato sauce and meatballs.",
      rating: 4.5,
      foodType: FoodTypeEnum.CookedFood,
      imageUrl:
          "https://www.spendwithpennies.com/wp-content/uploads/2019/03/Spaghetti-and-Meatballs-SpendWithPennies-4.jpg"),
  FoodItemModel(
      foodName: "Indomie Noodles",
      price: 500,
      description:
          "Indomie is a unique brand of Instant Noodles, loved by a majority of Nigerians. It has grown to become a household name in Nigeria owing to its delightful taste and wholesomeness. Transcending across all age groups, the brand has managed to win over the hearts and taste palates of both the young and the old.",
      rating: 4.5,
      foodType: FoodTypeEnum.CookedFood,
      imageUrl: "https://pbs.twimg.com/media/CZJxFdmUYAA-F0j.jpg"),
  FoodItemModel(
      foodName: "Custard And Milk",
      price: 500,
      description:
          "Custard is a variety of culinary preparations based on sweetened milk, cheese, or cream cooked with egg or egg yolk to thicken it, and sometimes also flour, corn starch, or gelatin. Depending on the recipe, custard may vary in consistency from a thin pouring sauce (crème anglaise) to the thick pastry cream (crème pâtissière) used to fill éclairs. The most common custards are used in custard desserts or dessert sauces and typically include sugar and vanilla; however, savory custards are also found, e.g., in quiche.",
      rating: 4.5,
      foodType: FoodTypeEnum.CookedFood,
      imageUrl:
          "https://www.indianhealthyrecipes.com/wp-content/uploads/2018/10/fruit-custard-recipe.jpg"),
  FoodItemModel(
      foodName: "Pepper soup",
      price: 500,
      description:
          "Peppersoup is a soup from parts of West Africa, notably Nigeria that is prepared using various meats, chili peppers and calabash nutmeg as primary ingredients. It is a spicy soup that has a light, watery texture. It is considered to be a delicacy by some people in Western Africa, and some West Africans believe that the soup has medicinal qualities.",
      rating: 4.5,
      foodType: FoodTypeEnum.CookedFood,
      imageUrl:
          "https://allnigerianfoods.com/wp-content/uploads/pepper-soup.jpg"),
  FoodItemModel(
      foodName: "Egusi",
      price: 500,
      description:
          "Egusi (also known by variations including agusi, agushi) is the name for the fat- and protein-rich seeds of certain cucurbitaceous plants (squash, melon, gourd), which after being dried and ground are used as a major ingredient in West African cuisine",
      rating: 4.5,
      foodType: FoodTypeEnum.CookedFood,
      imageUrl: "https://i.ytimg.com/vi/2C_zofzl0oY/maxresdefault.jpg"),
  FoodItemModel(
      foodName: "Àmàlà And Ewedu",
      price: 500,
      description:
          "Àmàlà is a local indigenous Nigerian food, native to the Yoruba ethnic group in the western states of the country. It is made out of yam and/or cassava flour, or unripe plantain flour. Yams are peeled, sliced, cleaned, dried and then blended into a flour, also called elubo. Yams are white in colour but turn brown when dried. This gives àmàlà its colour. Àmàlà is from Western Africa and eaten mostly by the Yoruba people in Nigeria. Amala is mainly consumed by indigenous people of the Southwestern part of Nigeria. It could be served with a variety of ọbẹ (soups), such as ẹfọ, ilá, ewédú, ogbono or gbegiri (black-eyed beans soup).",
      rating: 4.5,
      foodType: FoodTypeEnum.CookedFood,
      imageUrl:
          "https://fabwoman.ng/wp-content/uploads/2017/11/Gbegiri-soup.jpg"),
  FoodItemModel(
      foodName: "Ogbono soup",
      price: 500,
      description:
          "Ogbono soup, is a Nigerian igbo dish made with ground dry ogbono seeds (the local name for Irvingia) with considerable local variation. The ground ogbono seeds are used as a thickener, and give the soup a black coloration. Besides seeds, water and palm oil, it typically contains meat and/or fish seasonings such as chili pepper, leaf vegetables and other vegetables. Typical leaf vegetables include bitterleaf and celosia. Typical other vegetables include tomatoes and okra. Typical seasonings include chiles, onions, and iru (fermented locust beans). Typical meats include beef, goat, fish, chicken, bush meat, shrimp, or crayfish. It can be eaten with fufu,or with Pounded Yam In other countries the soup may be available in packaged prepared form in some markets that specialize in Western African foods. Ogbono soup has a mucilaginous (slimy) texture, similar to okra soup.",
      rating: 4.5,
      foodType: FoodTypeEnum.CookedFood,
      imageUrl:
          "https://farmcityltd.com/wp-content/uploads/2014/07/ogbono-1-1.jpg"),
  FoodItemModel(
      foodName: "Okro soup",
      price: 500,
      description:
          "Okra or Okro soup is prepared using the edible green seed pods of the okra flowering plant as a primary ingredient. It is greenish in colour. Okra has a slippery feel when rubbed with the fingers. The edible green seed pods can also be used in stews and soups",
      rating: 4.5,
      foodType: FoodTypeEnum.CookedFood,
      imageUrl: "https://i.ytimg.com/vi/bV2sg6mmSH8/maxresdefault.jpg"),
  FoodItemModel(
      foodName: "Ẹ̀fọ́ riro",
      price: 500,
      description:
          "Ẹ̀fọ́ riro is a spinach stew from Yorùbá cuisine prepared with vegetables and stockfish, palm oil, crayfish, pepper, locust bean and may also include meat and other ingredients",
      rating: 4.5,
      foodType: FoodTypeEnum.CookedFood,
      imageUrl:
          "https://sisijemimah.com/wp-content/uploads/2016/11/kale-efo-riro-9.jpg"),
  FoodItemModel(
      foodName: "Banga Soup And Starch",
      price: 500,
      description:
          "Banga, also known as Oghwo amiedi in Urhobo language and izuwo ibiedi in Isoko language, is a type of palm fruit soup from Southern the Niger Delta Nigeria particularly the Itsekiri ethnic group. This cuisine is quite different from 'Ofe Akwu' which is a variant found in Igbo culture. The Binis have a soup from palm fruits similar to 'Ofe Aku' in ingredients and manner of preparation.",
      rating: 4.5,
      foodType: FoodTypeEnum.CookedFood,
      imageUrl:
          "https://ocdn.eu/pulscms-transforms/1/9OzktkqTURBXy84MWZkZGE4ZDM5NzAxYTU5NmVjNGVkYWE2NzRmNzk3YS5qcGVnkpUDAF7NAoDNAWiTBc0DFM0BvA"),
  FoodItemModel(
      foodName: "Owo Soup",
      price: 500,
      description:
          " Owo is a traditional soup/sauce, native to the south – southern region of Nigerian(Benin-Bini, Urhobo, Delta, Itsekhiri, Ijaw, Isoko). It is a popular soup with a few variations, from different tribes.",
      rating: 4.5,
      foodType: FoodTypeEnum.CookedFood,
      imageUrl:
          "https://howtocookmeal.com/wp-content/uploads/2020/07/owo-soup.png"),
  FoodItemModel(
      foodName: "Yam And Egg",
      price: 500,
      description: "",
      rating: 4.5,
      foodType: FoodTypeEnum.CookedFood,
      imageUrl:
          "https://i2.wp.com/www.myactivekitchen.com/wp-content/uploads/2015/03/yam-and-egg-sauce-image-1.jpg?w=600&ssl=1"),

  /// snacks
  FoodItemModel(
    foodName: "Hamburger",
    price: 500,
    description:
        "A hamburger is a sandwich consisting of one or more cooked patties of ground meat, usually beef, placed inside a sliced bread roll or bun. The patty may be pan fried, grilled, smoked or flame broiled. ",
    rating: 4.5,
    foodType: FoodTypeEnum.Snacks,
    imageUrl:
        "https://media1.s-nbcnews.com/i/newscms/2019_21/2870431/190524-classic-american-cheeseburger-ew-207p_d9270c5c545b30ea094084c7f2342eb4.jpg",
  ),
  FoodItemModel(
    foodName: "Pizza",
    price: 500,
    description:
        "Pizza is a savory dish of Italian origin consisting of a usually round, flattened base of leavened wheat-based dough topped with tomatoes, cheese, and often various other ingredients, which is then baked at a high temperature, traditionally in a wood-fired oven. A small pizza is sometimes called a pizzetta.",
    rating: 4.5,
    foodType: FoodTypeEnum.Snacks,
    imageUrl:
        "https://img.foodlogistics.com/files/base/acbm/fl/image/2018/03/pizza_hut.5a98457c37496.png?auto=format&fit=max&w=1200",
  ),
  FoodItemModel(
    foodName: "Shawarma",
    price: 500,
    description:
        "Shawarma is a dish in Middle Eastern cuisine consisting of meat cut into thin slices, stacked in a cone-like shape, and roasted on a slowly-turning vertical rotisserie or spit. Originally made of lamb or mutton, today's shawarma may also be chicken, turkey, beef, or veal.",
    rating: 4.5,
    foodType: FoodTypeEnum.Snacks,
    imageUrl:
        "https://www.thespruceeats.com/thmb/qWxT_QU0PlqphVPfgMtfQjSKPO0=/1867x1867/smart/filters:no_upscale()/chicken-shawarma-138740297-58260f943df78c6f6acabb5b.jpg",
  ),
  FoodItemModel(
    foodName: "Chicken And Chips",
    price: 500,
    description:
        "Chicken and chips is a combination of foods predominantly consumed in the United Kingdom, The Commonwealth, and United States. It consists of a piece of fried, roasted, or barbecued chicken and chips, or French fries as they are known in the U.S.",
    rating: 4.5,
    foodType: FoodTypeEnum.Snacks,
    imageUrl:
        "https://www.recipetineats.com/wp-content/uploads/2020/01/Fried-Chicken_2-SQ.jpg",
  ),
  FoodItemModel(
    foodName: "French fries",
    price: 500,
    description:
        "French fries, or simply fries, chips, finger chips, or French-fried potatoes, are batonnet or allumette-cut deep-fried potatoes",
    rating: 4.5,
    foodType: FoodTypeEnum.Snacks,
    imageUrl:
        "https://kirbiecravings.com/wp-content/uploads/2019/09/easy-french-fries-1.jpg",
  ),
  FoodItemModel(
    foodName: "Meat pie",
    price: 500,
    description:
        "A meat pie is a pie with a chunky filling of meat and often other savory ingredients. They are popular in the United Kingdom, Australia, Ghana, Nigeria, Europe, New Zealand, Canada, Zimbabwe and South Africa.",
    rating: 4.5,
    foodType: FoodTypeEnum.Snacks,
    imageUrl: "https://i.ytimg.com/vi/ZXM0ZZM9Mjs/maxresdefault.jpg",
  ),
  FoodItemModel(
    foodName: "Chicken and mushroom pie",
    price: 500,
    description:
        "Chicken and mushroom pie is a common British pie, ranked as one of the most popular types of savoury pie in Great Britain and often served in fish and chips restaurants.",
    rating: 4.5,
    foodType: FoodTypeEnum.Snacks,
    imageUrl:
        "https://www.belle.ng/pub/media/catalog/product//i/m/images_50__1.jpeg",
  ),
  FoodItemModel(
    foodName: "Chin chin",
    price: 500,
    description:
        "it Chin chin is a fried snack in West Africa. It is known for its health benefits as well. It is similar to the Scandinavian snack klenat, a crunchy, donut-like baked or fried dough of wheat flour, and other customary baking items. Chin chin may contain cowpeas. Many people bake it with ground nutmeg for flavor.",
    rating: 4.5,
    foodType: FoodTypeEnum.Snacks,
    imageUrl:
        "https://aliyahsrecipesandtips.com/wp-content/uploads/2017/11/chin-chin-in-jars.jpg",
  ),
  FoodItemModel(
    foodName: "Doughnut",
    price: 500,
    description:
        "A doughnut or donut is a type of fried dough confection or dessert food. It is popular in many countries and is prepared in various forms as a sweet snack that can be homemade or purchased in bakeries, supermarkets, food stalls, and franchised specialty vendors",
    rating: 4.5,
    foodType: FoodTypeEnum.Snacks,
    imageUrl:
        "https://www.biggerbolderbaking.com/wp-content/uploads/2020/11/Homemade-Dunkin-Donuts-WS-Thumb-scaled.jpg",
  ),
  FoodItemModel(
    foodName: "Cup cake",
    price: 500,
    description:
        "A cupcake is a small cake designed to serve one person, which may be baked in a small thin paper or aluminum cup. As with larger cakes, frosting and other cake decorations such as fruit and candy may be applied",
    rating: 4.5,
    foodType: FoodTypeEnum.Snacks,
    imageUrl:
        "https://i.pinimg.com/originals/2c/b0/33/2cb03386b3d881f429aa5988662d2f87.jpg",
  ),

  /// drinks
  FoodItemModel(
    foodName: "Coca Cola",
    price: 100,
    description:
        "Coca-Cola, or Coke, is a carbonated soft drink manufactured by The Coca-Cola Company. Originally marketed as a temperance drink and intended as a patent medicine, it was invented in the late 19th century ... ",
    rating: 4.0,
    foodType: FoodTypeEnum.Drinks,
    imageUrl:
        "https://cdn-a.william-reed.com/var/wrbm_gb_food_pharma/storage/images/publications/food-beverage-nutrition/beveragedaily.com/article/2019/07/12/diet-coke-helps-boost-coca-cola-s-brand-value-brand-finance-rankings/9912727-1-eng-GB/Diet-Coke-helps-boost-Coca-Cola-s-brand-value-Brand-Finance-rankings_wrbm_large.jpg",
  ),
  FoodItemModel(
    foodName: "Tea",
    price: 100,
    description:
        "Tea is an aromatic beverage commonly prepared by pouring hot or boiling water over cured or fresh leaves of the Camellia sinensis, an evergreen shrub native to East Asia. After water, it is the most widely consumed drink in the world",
    rating: 4.0,
    foodType: FoodTypeEnum.Drinks,
    imageUrl:
        "https://cdn-a.william-reed.com/var/wrbm_gb_food_pharma/storage/images/publications/food-beverage-nutrition/beveragedaily.com/article/2020/01/31/what-next-for-lipton-and-pg-tips-unilever-s-strategic-tea-review/10657232-5-eng-GB/What-next-for-Lipton-and-PG-Tips-Unilever-s-strategic-tea-review_wrbm_large.jpg",
  ),
  FoodItemModel(
    foodName: "Fanta",
    price: 100,
    description:
        "Fanta is a brand of fruit-flavored carbonated soft drinks created by Coca-Cola Deutschland under the leadership of German businessman Max Keith. There are more than 100 flavors worldwide",
    rating: 4.0,
    foodType: FoodTypeEnum.Drinks,
    imageUrl:
        "https://theaustralianfoodshop.com/wp-content/uploads/2020/06/download.jfif_.jpg",
  ),
  FoodItemModel(
    foodName: "Monster Energy",
    price: 100,
    description:
        "Monster Energy is an energy drink that was introduced by Hansen Natural Company in April of 2002. Monster Energy has a 35% share of the energy drink market, the second highest share after Red Bull",
    rating: 4.0,
    foodType: FoodTypeEnum.Drinks,
    imageUrl:
        "https://i.pinimg.com/originals/d8/00/27/d800274fc8a82a734d495af0c59e6759.jpg",
  ),
  FoodItemModel(
    foodName: "Coffee",
    price: 100,
    description:
        "Coffee is a brewed drink prepared from roasted coffee beans, the seeds of berries from certain Coffea species. When coffee berries turn from green to bright red in color – indicating ripeness – they are picked, processed, and dried. Dried coffee seeds are roasted to varying degrees, depending on the desired flavor.",
    rating: 4.0,
    foodType: FoodTypeEnum.Drinks,
    imageUrl:
        "https://coffeemakerguy.com/wp-content/uploads/2020/04/621f79c3-98dc-4596-ac58-884063acadc0.jpg",
  ),
];
