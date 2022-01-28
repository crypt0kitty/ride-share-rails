
module DriversHelper
  def driver_online_string(driver)
    driver.available? ? "Driver: Online" : "Driver: Offline"
  end
  
  def driver_availability_string(driver)
    driver.available? ? "YES": "NO"
  end
end
