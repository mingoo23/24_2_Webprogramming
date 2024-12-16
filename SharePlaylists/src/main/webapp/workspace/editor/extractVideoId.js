function getYoutubeVideoId(url) {
  const regex = /(?:youtu\.be\/|youtube\.com\/(?:watch\?v=|embed\/|v\/|shorts\/))([^#&?]{11})/;
  const match = url.match(regex);
  return match ? match[1] : null;
}
