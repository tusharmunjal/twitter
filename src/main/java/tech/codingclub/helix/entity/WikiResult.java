package tech.codingclub.helix.entity;
public class WikiResult {

    private String query;
    private String text_result;
    private String image_url;
    public WikiResult(String query, String textResult, String imageUrl)
    {
        this.query = query;
        text_result = textResult;
        image_url = imageUrl;
    }
    public String getQuery(){
        return query;
    }
    public String getText_result(){
        return text_result;
    }
    public String getImage_url(){
        return image_url;
    }

}
