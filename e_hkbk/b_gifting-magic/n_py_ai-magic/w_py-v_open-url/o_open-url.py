from selenium import webdriver

# Provide the path to your Firefox driver executable
firefox_driver_path = 'path/to/geckodriver'

# Provide the URL of the webpage you want to open
url = 'https://www.example.com'

# Set up the Firefox driver
firefox_options = webdriver.FirefoxOptions()
firefox_options.add_argument('-headless')  # Optional: Run Firefox in headless mode (without GUI)
driver = webdriver.Firefox(executable_path=firefox_driver_path, options=firefox_options)

# Open the webpage
driver.get(url)

# You can perform further actions with the opened webpage here, such as interacting with elements or extracting data

# Close the browser
driver.quit()
