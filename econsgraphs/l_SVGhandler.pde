String getSVGString(PGraphicsSVG svg){
  // make a binary output stream
  ByteArrayOutputStream output = new ByteArrayOutputStream();
  // make a writer for it
  Writer writer = PApplet.createWriter(output);
  // same way the library writes to disk we write to the byte array stream
  try{
    ((SVGGraphics2D) svg.g2).stream(writer, false);
  } catch (Exception e) {
      e.printStackTrace();
  }
  // convert bytes to an UTF-8 encoded string
  return new String( output.toByteArray(), StandardCharsets.UTF_8 );
}

void copyToClipboard(PGraphicsSVG svg){
  // get the SVG markup as a string
  String svgString = getSVGString(svg);;
  println(svgString);
  // access the system clipboard
  Clipboard clip = Toolkit.getDefaultToolkit().getSystemClipboard();
  // get an binary clipboard with the correct SVG MIME type
  SvgClip strSVG = new SvgClip(svgString);
  // commit the clipboard encoded SVG to clipboard 
  clip.setContents(strSVG, null);
}

void copyToClipboard(String svg){
  // get the SVG markup as a string
  String svgString = (svg);
  println(svgString);
  // access the system clipboard
  Clipboard clip = Toolkit.getDefaultToolkit().getSystemClipboard();
  // get an binary clipboard with the correct SVG MIME type
  SvgClip strSVG = new SvgClip(svgString);
  // commit the clipboard encoded SVG to clipboard 
  clip.setContents(strSVG, null);
}

// blatant copy/adapation of https://stackoverflow.com/questions/33726321/how-to-transfer-svg-image-to-other-programs-with-dragndrop-in-java
class SvgClip implements Transferable{

    String svgString;

    DataFlavor svgFlavor = new DataFlavor("image/svg+xml; class=java.io.InputStream","Scalable Vector Graphic");

    DataFlavor [] supportedFlavors = {svgFlavor};

    SvgClip(String svgString){
        this.svgString = svgString;

        SystemFlavorMap systemFlavorMap = (SystemFlavorMap) SystemFlavorMap.getDefaultFlavorMap();
        systemFlavorMap.addUnencodedNativeForFlavor(svgFlavor, "image/svg+xml");
    }

    @Override public DataFlavor[] getTransferDataFlavors(){
          return this.supportedFlavors;    
    }

    @Override public boolean isDataFlavorSupported(DataFlavor flavor){
       return true;
    }

    @Override public Object getTransferData(DataFlavor flavor)
            throws UnsupportedFlavorException, IOException{
        return new ByteArrayInputStream(svgString.getBytes(StandardCharsets.UTF_8));
    }

}
