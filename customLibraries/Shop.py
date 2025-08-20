from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn

#file name  and class nae should be same
@library
class Shop:

    def __init__(self):
        self.selLib = BuiltIn().get_library_instance("SeleniumLibrary") #to import these library which is built in lib

    @keyword
    def hello_world(self):
        print("hello")

    @keyword
    def add_items_to_cart_and_checkout(self, productsList): # list will be catched in this product list
        # Get WebElements
        i = 1
        productsTitles = self.selLib.get_webelements(" css:.card-title") #stored path this way
        for productsTitle in productsTitles:
            if productsTitle.text in productsList:
                self.selLib.click_button("xpath:(//*[@class='card-footer'])["+str(i)+"]/button")

            i = i + 1

        self.selLib.click_link("css:li.active a")













