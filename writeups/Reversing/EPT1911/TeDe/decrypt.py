import xml.etree.ElementTree as ET
xml = "<?xml version=\"1.0\" encoding=\"utf-16\"?>\r\n<ArrayOfString xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\r\n  <string>58</string>\r\n  <string>7</string>\r\n  <string>58</string>\r\n  <string>53</string>\r\n  <string>43</string>\r\n  <string>53</string>\r\n  <string>65</string>\r\n  <string>68</string>\r\n  <string>6</string>\r\n  <string>77</string>\r\n  <string>53</string>\r\n  <string>72</string>\r\n  <string>48</string>\r\n  <string>72</string>\r\n  <string>7</string>\r\n  <string>15</string>\r\n  <string>7</string>\r\n  <string>7</string>\r\n  <string>53</string>\r\n  <string>40</string>\r\n  <string>53</string>\r\n  <string>68</string>\r\n  <string>6</string>\r\n  <string>72</string>\r\n  <string>77</string>\r\n  <string>9</string>\r\n  <string>61</string>\r\n  <string>63</string>\r\n  <string>55</string>\r\n  <string>68</string>\r\n  <string>21</string>\r\n</ArrayOfString>"
enc_pw = ET.fromstring(xml)

flag = "EPT{"
for char in enc_pw:
    flag += chr(int(char.text)+42)
flag += "!}"
print(flag)