var chrome = require('selenium-webdriver/chrome');
var webdriver = require('selenium-webdriver'),
    By = webdriver.By,
    until = webdriver.until;


// alternate form of setting mobile state
// var capa = webdriver.Capabilities.chrome().set("chromeOptions",{
// 	"mobileEmulation": { "deviceName": "Google Nexus 5" }
// });
// var options = chrome.Options.fromCapabilities(capa);

var	options = new chrome.Options().setMobileEmulation({ "deviceName": "Google Nexus 5" })


var driver1 = new webdriver.Builder()
    .forBrowser('chrome')
    .usingServer('http://localhost:4444/wd/hub')
    .setChromeOptions(options)
    .build();

var driver2 = new webdriver.Builder()
    .forBrowser('chrome')
    .usingServer('http://localhost:4444/wd/hub')
    .build();

	driver1.get('http://www.heute-show.de');
	driver1.executeScript('$(".header .searchicon").click()');
	driver1.executeScript('$(".header .searchfield").val("merkel")');
	driver1.executeScript('$(".header .searchicon").click()');
	driver1.executeScript('document.body.parentElement.setAttribute("style", "overflow: hidden")');

	driver1.wait(until.titleIs('Suche – heute-show | ZDF'), 1000).then( ()=> {
		driver1.takeScreenshot().then((data) => {
			const fs = require('fs');
			var base64Data = data.replace(/^data:image\/png;base64,/,"")
			fs.writeFile("out1.png", base64Data, 'base64', function(err) {
			    if(err) console.log(err);
			    driver1.quit();
			});
		});		
	})

	driver2.get('http://www.heute-show.de');
	driver2.executeScript('$(".header .searchicon").click()');
	driver2.executeScript('$(".header .searchfield").val("merkel")');
	driver2.executeScript('$(".header .searchicon").click()');
    driver2.executeScript('document.body.parentElement.setAttribute("style", "overflow: hidden")');	
	driver2.wait(until.titleIs('Suche – heute-show | ZDF'), 1000).then( () => {
		driver2.takeScreenshot().then((data) => {
			const fs = require('fs');
			var base64Data = data.replace(/^data:image\/png;base64,/,"")
			fs.writeFile("out2.png", base64Data, 'base64', function(err) {
			    if(err) console.log(err);
			    driver2.quit();
			});
		});
	})





// options.setMobileEmulation(o.mobileEmulation)









// from selenium import webdriver
// mobile_emulation = { "deviceName": "Google Nexus 5" }
// chrome_options = webdriver.ChromeOptions()
// chrome_options.add_experimental_option("mobileEmulation", mobile_emulation)
// driver = webdriver.Remote(command_executor='http://127.0.0.1:4444/wd/hub',
//                           desired_capabilities = chrome_options.to_capabilities())

/*
Map<String, String> deviceMetrics = new HashMap<String, Object>();
deviceMetrics.put("width", 360);
deviceMetrics.put("height", 640);
deviceMetrics.put("pixelRatio", 3.0);
Map<String, String> mobileEmulation = new HashMap<String, String>();

mobileEmulation.put("deviceMetrics", deviceMetrics);
mobileEmulation.put("userAgent", "Mozilla/5.0 (Linux; Android 4.2.1; en-us; Nexus 5 Build/JOP40D) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.166 Mobile Safari/535.19");

Map<String, Object> chromeOptions = new Map<String, Object>();
chromeOptions.put("mobileEmulation", mobileEmulation);
DesiredCapabilities capabilities = DesiredCapabilities.chrome();
capabilities.setCapability(ChromeOptions.CAPABILITY, chromeOptions);
WebDriver driver = new ChromeDriver(capabilities);
*/