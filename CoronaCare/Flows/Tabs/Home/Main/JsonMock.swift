//
//  JsonMock.swift
//  CoronaCare
//
//  Created by Behrad Kazemi on 3/31/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
import Domain
enum JsonMock {
	static let homeEN = """
[
  {
    "type": 1,
    "id": 123,
    "title": "What To Do if You Are Sick",
    "headline": "Call your doctor:\\nIf you think you have been developed a fever and symptoms, such as cough or difficulty breathing, call your healthcare provider for medical advice.",
    "thumbnail": "https://raw.githubusercontent.com/behrad-kzm/BEKDesing/master/Images/CoronaCare/Post_1.jpg",
    "description": "Life goes on when you're sick. But if you have cold symptoms, there are some things worth skipping, as well as to-dos that can help you get better. Your body needs rest to recover. And while it's important to focus on your health, you should also be sure you're doing all you can to keep those around you from catching what you have.\\nThese five tips will help you figure out what you should do when you're sick and what can wait until you're on the mend.\\n\\nfollow the steps below to help prevent the disease from spreading to people in your home and community.\\nStay home except to get medical care\\n\\n- You should restrict activities outside your home, except for getting medical care.\\n- Avoid public areas: Do not go to work, school, or public areas.\\n- Avoid public transportation: Avoid using public transportation, ride-sharing, or taxis.\\n",
    "src": "https://www.verywellhealth.com/dos-donts-when-sick-770370"
  },
{
	"type": 1,
	"id": 124,
	"title": "Tips for washing hands",
	"headline": "Handwashing is one of the best ways to protect yourself and your family from getting sick. Learn when and how you should wash your hands to stay healthy.",
	"thumbnail": "https://raw.githubusercontent.com/behrad-kzm/BEKDesing/master/Images/CoronaCare/Post_2.jpg",
	"description": "You can help yourself and your loved ones stay healthy by washing your hands often, especially during these key times when you are likely to get and spread germs:\\n\\n- Before, during, and after preparing food\\n- Before eating food\\n- Before and after caring for someone at home who is sick with vomiting or diarrhea\\n- Before and after treating a cut or wound\\n- After using the toilet\\n- After changing diapers or cleaning up a child who has used the toilet\\n- After blowing your nose, coughing, or sneezing\\n- After touching an animal, animal feed, or animal waste\\n- After handling pet food or pet treats\\n- After touching garbage\\n",
	"src": "https://www.cdc.gov/handwashing/when-how-handwashing.html"
	},
{
	"type": 2,
	"id": 125,
	"title": "Best way to wash hands",
	"headline": "Handwashing can help prevent illness",
	"thumbnail": "https://raw.githubusercontent.com/behrad-kzm/BEKDesing/master/Images/CoronaCare/Post_3.jpg",
	"description": "Handwashing can help prevent illness. It involves five simple and effective steps (Wet, Lather, Scrub, Rinse, Dry) you can take to reduce the spread of diarrheal and respiratory illness so you can stay healthy. Regular handwashing, particularly before and after certain activities, is one of the best ways to remove germs, avoid getting sick, and prevent the spread of germs to others. Itâ€™s quick, itâ€™s simple, and it can keep us all from getting sick. Handwashing is a win for everyone, except for the germs.",
	"src": "https://youtu.be/o6S_qlJf0e8"
},
{
	"type": 1,
	"id": 126,
	"title": "What Are Viruses?",
	"headline": "Viruses are microscopic parasites, generally much smaller than bacteria. They lack the capacity to thrive and reproduce outside of a host body.",
	"thumbnail": "https://cdn.mos.cms.futurecdn.net/X3fuDG3ZfaWHVBJzdCgvS9-650-80.jpg",
	"description": "Predominantly, viruses have a reputation for being the cause of contagion. Widespread events of disease and death have no doubt bolstered such a reputation. The 2014 outbreak of Ebola in West Africa, and the 2009 H1N1/swine flu pandemic (a widespread global outbreak) likely come to mind.\\nWhile such viruses certainly are wily foes for scientists and medical professionals, others of their ilk have been instrumental as research tools; furthering the understanding of basic cellular processes such as the mechanics of protein synthesis, and of viruses themselves. ",
	"src": "https://www.livescience.com/53272-what-is-a-virus.html"
}
]
"""
	
	static let homeFA = """
	[
		{
			"type": 1,
			"id": 123,
			"title": "بعد از سرما خوردن چه کار کنیم؟",
			"headline": "با پزشک خود تماس بگیرید:\\nاگر فکر می کنید تب و علائمی مانند سرفه یا مشکل در تنفس ایجاد شده است ، برای مشاوره پزشکی با ارائه دهنده خدمات پزشکی تماس بگیرید.",
			"thumbnail": "https://raw.githubusercontent.com/behrad-kzm/BEKDesing/master/Images/CoronaCare/Post_1.jpg",
			"description": "زندگی وقتی بیمار می شوید ادامه دارد. اما اگر علائم سرماخوردگی دارید، مواردی وجود دارد که ارزش رد شدن از آنها را دارند، و همچنین ‘لیست انجام دادنی‌ها’ وجود دارد که می تواند به شما در بهتر شدن کمک کند. بدن شما برای بهبود به استراحت نیاز دارد. اگرچه توجه به سلامتی شما مهم است، باید اطمینان داشته باشید که تمام تلاش خود را کنید تا اطرافیان خود را مبتلا نکنید. این پنج نکته به شما کمک می کند که چه کاری تا انتهای بیماری باید انجام دهید تا مراحل بهبودی را طی کنید. مراحل زیر را دنبال کنید تا از شیوع بیماری افراد در خانه و اجتماع جلوگیری کنید.\\n در خانه بمانید جز مراقبت های پزشکی. شما باید فعالیت های خارج از خانه خود را محدود کنید، به جز مراقبت های پزشکی.  از مکان های عمومی خودداری کنید: به محل کار، مدرسه یا\\nمحل های عمومی نروید.از حمل و نقل عمومی خودداری کنید. از استفاده از وسایل \\nحمل و نقل عمومی ، اتوبوس یا تاکسی خودداری کنید.",
			"src": "https://www.verywellhealth.com/dos-donts-when-sick-770370"
		},
		{
			"type": 1,
			"id": 124,
			"title": "نکاتی برای شستن دستها",
			"headline": "شستشوی دست یکی از بهترین راه های محافظت از خود و خانواده در برابر بیماری است. بدانید چه موقع و چگونه شما باید دست خود برای سالم ماندن بشویید.",
			"thumbnail": "https://raw.githubusercontent.com/behrad-kzm/BEKDesing/master/Images/CoronaCare/Post_2.jpg",
			"description": "شما می توانید با شستن مرتب دست خود، به خصوص در مواقع بیماری که احتمالاً میکروب ها را می گیرید و پخش می کنید ، به خود و عزیزان خود کمک کنید: \\n- قبل ، حین و بعد از تهیه غذا  \\n- قبل از خوردن غذا  \\n- قبل و بعد از مراقبت از شخصی در خانه که از استفراغ یا اسهال بیمار است  \\n- قبل و بعد از درمان بریدگی یا زخم  \\n- بعد از استفاده از توالت  \\n- بعد از تعویض پوشک یا تمیز کردن کودکی که استفاده کرده باشد سرویس بهداشتی  \\n- بعد از دمیدن بینی ، سرفه یا عطسه کردن شما  \\n- بعد از دست زدن به حیوان ، خوراک حیوانات یا زباله های حیوانات  \\n- بعد از دست زدن به غذای حیوانات خانگی یا معالجه حیوانات خانگی  \\n- بعد بعد از دست زدن به زباله ها  -\\n",
			"src": "https://www.cdc.gov/handwashing/when-how-handwashing.html"
		},
		{
			"type": 2,
			"id": 125,
			"title": "بهترین روش برای شستن دستها",
			"headline": "شستشوی دست می تواند به جلوگیری از بیماری کمک کند",
			"thumbnail": "https://raw.githubusercontent.com/behrad-kzm/BEKDesing/master/Images/CoronaCare/Post_3.jpg",
			"description": "شستشوی دست می تواند به جلوگیری از بیماری کمک کند. این شامل پنج مرحله ساده و مؤثر (مرطوب ، پوستی ، اسکراب ، شستشو ، خشک) است که می توانید برای کاهش شیوع اسهال و بیماری های تنفسی انجام دهید تا بتوانید سالم بمانید. شستشوی منظم دست ، بویژه قبل و بعد از فعالیتهای خاص ، یکی از بهترین راه ها برای از بین بردن میکروب ها ، جلوگیری از بیمار شدن و جلوگیری از شیوع میکروب به دیگران است. این سریع است ، ساده است و می تواند همه ما را از ابتلا به بیماری نجات دهد. شستن دست ، پیروزی برای همه است ، به جز میکروب ها.",
			"src": "https://youtu.be/o6S_qlJf0e8"
		},
		{
			"type": 1,
			"id": 126,
			"title": "ویروس چیست؟",
			"headline": "ویروس ها انگل های میکروسکوپی هستند ، به طور کلی بسیار کوچکتر از باکتری ها. آنها توانایی رشد و تکثیر در خارج از بدن میزبان را ندارند.",
			"thumbnail": "https://cdn.mos.cms.futurecdn.net/X3fuDG3ZfaWHVBJzdCgvS9-650-80.jpg",
			"description": "پیش از این ، ویروس ها به دلیل عامل عفونت شهرت دارند. بدون شک وقایع گسترده بیماری و مرگ باعث افزایش چنین شهرت شده است. شیوع ابولا در غرب آفریقا در سال 2014 ، و بیماری همه گیر آنفولانزای خوکی H1N1 در سال 2009 (شیوع گسترده جهانی) احتمالاً به ذهن خطور می کند. هرچند چنین ویروس ها مطمئناً برای دانشمندان و متخصصان پزشکی دشمنان بدی هستند ، دیگران این نوع ابزارها نیز مؤثر بوده اند. ابزار تحقیق؛ پیشرفت در درک فرآیندهای اساسی سلولی مانند مکانیک سنتز پروتئین و خود ویروس ها.",
			"src": "https://www.livescience.com/53272-what-is-a-virus.html"
		}
	]
	"""
	
	static let homeCH = """
	[
		{
			"type": 1,
			"id": 123,
			"title": "如果您生病了该怎么办",
			"headline": "致电您的医生：\\n如果您认为自己发烧并出现了咳嗽或呼吸困难等症状，请致电您的医疗保健提供者以寻求医疗建议。",
			"thumbnail": "https://raw.githubusercontent.com/behrad-kzm/BEKDesing/master/Images/CoronaCare/Post_1.jpg",
			"description": "生病时生活会继续下去。 但是，如果您有感冒症状，则有些事情值得跳过，还有“待办事项”可以帮助您变得更好。 您的身体需要休息才能恢复。 并且，尽管重要的是要注意自己的健康，但还应确保您正在做所有力所能及的事情，以防止周围的人抓到自己所拥有的东西。\\n这五个技巧将帮助您弄清楚自己应该做什么。 生病了，可以等到您接受治疗后。\\n\\n请按照以下步骤操作，以防止疾病传播到您的家中和社区。\\n除获得医疗服务外，请留在家里\\n\\n-除获得医疗护理外，您应限制在家外的活动。\\n-避免进入公共场所：请勿上班，上学或在公共场所。\\n-避免公共交通工具：避免使用公共交通工具，拼车， 或出租车。\\n",
			"src": "https://www.verywellhealth.com/dos-donts-when-sick-770370"
		},
		{
			"type": 1,
			"id": 124,
			"title": "洗手提示",
			"headline": "洗手是保护自己和家人不生病的最佳方法之一。 了解何时以及如何洗手以保持健康。",
			"thumbnail": "https://raw.githubusercontent.com/behrad-kzm/BEKDesing/master/Images/CoronaCare/Post_2.jpg",
			"description": "您可以通过经常洗手来帮助自己和亲人保持健康，尤其是在以下关键时期，即您很可能会吸收和传播细菌时：\\n\\n-准备食物之前，期间和之后\\n-吃食物之前 \\n-在家里照顾呕吐或腹泻的人之前和之后\\n-在治疗伤口或伤口之前和之后\\n-在上厕所后\\n-在更换尿布或清理曾经使用过的孩子之后 上厕所\\n-blowing鼻子，咳嗽或打喷嚏后\\n-接触动物，动物饲料或动物废物后\\n-处理宠物食品或宠物零食后\\n-接触垃圾后\\n",
			"src": "https://www.cdc.gov/handwashing/when-how-handwashing.html"
		},
		{
			"type": 2,
			"id": 125,
			"title": "洗手的最佳方法",
			"headline": "洗手可以帮助预防疾病",
			"thumbnail": "https://raw.githubusercontent.com/behrad-kzm/BEKDesing/master/Images/CoronaCare/Post_3.jpg",
			"description": "洗手可以帮助预防疾病。它涉及五个简单而有效的步骤（湿，起泡，磨砂，冲洗，干燥），可以减少腹泻和呼吸道疾病的传播，从而保持健康。定期洗手，特别是在某些活动之前和之后，是去除细菌，避免生病和防止菌传播给他人的最佳方法之一。 它很快，它很简单，而且可以防止我们所有人生病。除细菌外，洗手对每个人都是胜利。",
			"src": "https://youtu.be/o6S_qlJf0e8"
		},
		{
			"type": 1,
			"id": 126,
			"title": "什么是病毒？",
			"headline": "病毒是微观寄生虫，通常比细菌小得多。 它们缺乏在宿主体外繁殖和繁殖的能力。",
			"thumbnail": "https://cdn.mos.cms.futurecdn.net/X3fuDG3ZfaWHVBJzdCgvS9-650-80.jpg",
			"description": "病毒主要是导致传染的声誉。 毫无疑问，疾病和死亡的广泛蔓延增强了这种声誉。 人们可能会想到2014年在西非爆发的埃博拉病毒以及2009年的H1N1猪流感大流行（全球性爆发）。 工具； 进一步了解基本的细胞过程，例如蛋白质合成的机制以及病毒本身。",
			"src": "https://www.livescience.com/53272-what-is-a-virus.html"
		}
	]
	"""
}
extension Languages {
	func asHomeJSON() -> [HomeNetworkModel] {
		var json: String
		switch self {
		case .fa:
				json = JsonMock.homeFA
				break
		case .zhHans:
				json = JsonMock.homeCH
				break
		default:
			json = JsonMock.homeEN
		}
		let jsonData = json.data(using: .utf8)!
		let homeResponse = try! JSONDecoder().decode([HomeNetworkModel].self, from: jsonData)
		return homeResponse
	}
}
