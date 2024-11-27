from datetime import datetime
def convert_to_24_hour( time_12):

 return datetime.strptime(time_12, "%I:%M %p").strftime("%H:%M")

