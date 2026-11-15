import Foundation

/// Static repository of Horoyoi flavors, editorial scenes, snack pairings, and official media URLs.
enum HoroyoiData {
    static let officialWebsiteURL = URL(string: "https://www.suntory.com.tw/Alcohol/horoyoi/")!

    static let flavors: [FlavorItem] = [
        FlavorItem(
            name: "白色沙瓦",
            jpName: "白いサワー",
            tagline: "酸甜乳酸交織微氣泡的經典白晝滋味",
            description: "以溫潤細膩的乳酸風味為基底，搭配柔和碳酸氣泡與恰到好處的 3% 低酒精濃度。入口滑順清爽、尾韻微甜不膩口，無論是初次接觸微醉或午後小憩，都是最安心陪伴的長銷經典。",
            abv: 3.0,
            sweetness: 4,
            acidity: 3,
            imageName: "can_white_sour",
            accentColorHex: "#6BAED6",
            isSeasonal: false,
            pairings: ["鹽味洋芋片", "起司可麗餅", "和風柚香毛豆"]
        ),
        FlavorItem(
            name: "白桃",
            jpName: "もも",
            tagline: "宛如咬下熟成水蜜桃般的芳醇甘甜",
            description: "萃取飽滿白桃果香，在開罐瞬間便能感受溫柔甜美的果實香氣。綿密氣泡將桃汁的圓潤甘甜輕柔包覆，微醺之間彷彿置身春日果園的柔和陽光裡。",
            abv: 3.0,
            sweetness: 5,
            acidity: 2,
            imageName: "can_peach",
            accentColorHex: "#F48FB1",
            isSeasonal: false,
            pairings: ["生火腿哈密瓜", "卡門貝爾起司", "香草戚風蛋糕"]
        ),
        FlavorItem(
            name: "葡萄沙瓦",
            jpName: "ぶどう",
            tagline: "深邃多汁的葡萄果韻，柔和點亮夜晚",
            description: "嚴選濃郁葡萄果汁調和微氣泡酒體，兼具果皮的微澀層次與果肉的豐沛甜度。冷藏後倒進玻璃杯中，微紫光澤與細緻氣泡特別適合搭配深夜電影時光。",
            abv: 3.0,
            sweetness: 4,
            acidity: 3,
            imageName: "can_grape",
            accentColorHex: "#9575CD",
            isSeasonal: false,
            pairings: ["煙燻堅果拼盤", "醬烤雞肉串", "黑胡椒蘇打餅"]
        ),
        FlavorItem(
            name: "葡萄柚",
            jpName: "グレープフルーツ",
            tagline: "微苦果皮與清爽柑橘酸度的大人系節奏",
            description: "完整保留紅白葡萄柚特有的清冽酸香與優雅微苦尾韻，讓低酒精飲品也能擁有俐落爽口的餐搭表現。下班後配上一份炸物或熱食，瞬間褪去整日的疲憊。",
            abv: 3.0,
            sweetness: 2,
            acidity: 5,
            imageName: "can_grapefruit",
            accentColorHex: "#FF8A65",
            isSeasonal: false,
            pairings: ["日式唐揚炸雞", "鹽烤秋刀魚", "檸檬椒鹽薯條"]
        ),
        FlavorItem(
            name: "草莓沙瓦",
            jpName: "いちご",
            tagline: "春季限定的酸甜莓果粉紅微氣泡",
            description: "將新鮮草莓的俏皮果酸與柔和乳感甜香揉合於一身，色澤粉嫩討喜。輕啜一口就能嘗到初戀般的輕盈層次，為週末午後或節慶聚會增添浪漫氣息。",
            abv: 3.0,
            sweetness: 4,
            acidity: 4,
            imageName: "can_strawberry",
            accentColorHex: "#EC407A",
            isSeasonal: true,
            pairings: ["奶油鬆餅", "海鹽堅果塔", "原味可頌"]
        ),
        FlavorItem(
            name: "荔枝沙瓦",
            jpName: "ライチ",
            tagline: "初夏限定的清透玉荷包花果芬芳",
            description: "以飽滿清甜的荔枝果汁為主角，融入微微海鹽般的爽朗感與細密氣泡。冰鎮後飲用格外透涼解膩，散發熱帶初夏獨有的清雅果香。",
            abv: 3.0,
            sweetness: 4,
            acidity: 3,
            imageName: "can_lychee",
            accentColorHex: "#4DB6AC",
            isSeasonal: true,
            pairings: ["椒麻涼拌小黃瓜", "泰式檸檬蝦餅", "炙燒干貝"]
        )
    ]

    static let scenes: [ScenePhoto] = [
        ScenePhoto(
            title: "週末夜晚的溫馨室內",
            moodTag: "#居家微醺",
            imageName: "scene_01",
            storyQuote: "把筆電闔上、換上舒服的居家服，搭配和風毛豆與堅果，讓 3% 氣泡陪你慢慢放空。"
        ),
        ScenePhoto(
            title: "居酒屋串燒與微醺夜晚",
            moodTag: "#串燒微醉",
            imageName: "scene_02",
            storyQuote: "炭火香氣飄散的木桌旁，一口鹽烤雞肉串配冰涼白桃微醉，褪去整日的疲憊。"
        ),
        ScenePhoto(
            title: "露營暖燈與起司餅乾搭配",
            moodTag: "#星空露營",
            imageName: "scene_03",
            storyQuote: "夜幕低垂、暖黃串燈亮起，在草地與木桌旁用白桃和葡萄沙瓦配起司餅乾乾杯。"
        ),
        ScenePhoto(
            title: "居家草莓蛋糕甜點搭配",
            moodTag: "#甜點時刻",
            imageName: "scene_04",
            storyQuote: "柔軟的草莓鮮奶油蛋糕遇上粉紅草莓微氣泡，在家也能擁有一份剛剛好甜美的儀式感。"
        ),
        ScenePhoto(
            title: "夜色窗邊閱讀與香氛蠟燭",
            moodTag: "#深夜讀書",
            imageName: "scene_05",
            storyQuote: "窗外城市燈火微亮、桌上燭火輕晃，不需要太濃烈的醉意，只要剛好的溫柔陪你讀完這一章。"
        ),
        ScenePhoto(
            title: "陽台黃昏微風與唐揚炸雞",
            moodTag: "#陽台晚風",
            imageName: "scene_06",
            storyQuote: "趁著黃昏的晚風坐在陽台小桌旁，酥脆唐揚炸雞與清冽柑橘微醉就是最愜意的下班句點。"
        )
    ]

    static let pairings: [FoodPairing] = [
        FoodPairing(
            name: "日式唐揚炸雞",
            category: "酥脆熱食",
            note: "葡萄柚或檸檬柑橘酸度能完美解膩，讓肉汁更加鮮甜。",
            symbolName: "flame.fill"
        ),
        FoodPairing(
            name: "和風鹽味毛豆",
            category: "清爽下酒",
            note: "淡淡海鹽與白色沙瓦的乳酸甜香形成絕妙平衡。",
            symbolName: "leaf.fill"
        ),
        FoodPairing(
            name: "卡門貝爾起司拼盤",
            category: "乳香小點",
            note: "滑順起司遇到白桃與草莓果香，瞬間化身法式微醺甜點。",
            symbolName: "takeoutbag.and.cup.and.straw.fill"
        ),
        FoodPairing(
            name: "海鹽厚切洋芋片",
            category: "超商良伴",
            note: "鹹脆口感搭配 3% 氣泡，是深夜追劇最零門檻的幸福組合。",
            symbolName: "sparkles"
        )
    ]

    static let remoteBannerURLs: [URL] = [
        URL(string: "https://www.suntory.com.tw/Alcohol/horoyoi/images/star1.png")!,
        URL(string: "https://www.suntory.com.tw/Alcohol/horoyoi/images/star2.png")!,
        URL(string: "https://www.suntory.com.tw/Alcohol/horoyoi/images/star1Mobile.jpg")!
    ]
}
