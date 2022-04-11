import XCTest

class MainUITests: TestCase {
    var homePage: HomePageObject!
    var detailPage: DetailPageObject!
    
    override func setUp() {
        super.setUp()
        
        homePage = HomePageObject(application: app)
        detailPage = DetailPageObject(application: app)
    }
    
    func testHappyPath() {
        app.launch()
        
        XCTAssert(homePage.waitToAppear(), "Home page should be visible.")
        homePage.tapOnDetailWidget()
        
        XCTAssert(detailPage.waitToAppear(), "At this point detail view controller should be visible.")
    }
}
