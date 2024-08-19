import speedtest

def measure_internet_speed():
    # Create a Speedtest object
    st = speedtest.Speedtest()

    # Perform the download speed test
    download_speed = st.download() / 10**6  # Convert to Mbps

    # Perform the upload speed test
    upload_speed = st.upload() / 10**6  # Convert to Mbps

    # Print the results
    print(f"Download Speed: {download_speed:.2f} Mbps")
    print(f"Upload Speed: {upload_speed:.2f} Mbps")

# Call the function to measure internet speed
measure_internet_speed()
