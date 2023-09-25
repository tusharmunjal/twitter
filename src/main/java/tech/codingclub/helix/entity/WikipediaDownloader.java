package tech.codingclub.helix.entity;


import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import tech.codingclub.helix.global.HttpURLConnectionExample;

public class WikipediaDownloader {

    private String keyword;

    public WikipediaDownloader()
    {

    }
    public WikipediaDownloader(String keyword) {
        this.keyword = keyword;
    }

    public WikiResult getResult() {
        //1.get clean keyword
        //2.get url for wikipedia
        //3.make a GET requuest to  wikipedia
        //4.parsing the useful result using jsoup
        //5.showing results

        if(this.keyword==null || this.keyword.length()==0)
        {
            return null;
        }
        //1
        this.keyword=this.keyword.trim().replaceAll("[ ]+","_");
        //2
        String wikiUrl=getWikipediaUrlForQuery(this.keyword);
        String responce="";
        String imageUrl = null;
        try {
            //3
            String wikipediaResponse= HttpURLConnectionExample.sendGet(wikiUrl);
            //System.out.println(wikipediaResponse);
            //4
            Document document= Jsoup.parse(wikipediaResponse,"https://en.wikipedia.org");
            Elements childElements=document.body().select(".mw- > *");
            int state=0;

            for(Element childElement : childElements)
            {
                if (state==0)
                {
                    if(childElement.tagName().equals("table"))
                    {
                        state=1;
                    }
                    else if(state==1){
                        if(childElement.tagName().equals("p"))
                        {
                            state=2;
                            responce=childElement.text();
                            break;
                        }
                    }
                }

                System.out.println(childElement.tagName());
                //if(childElement.tagName())
            }
            try
            {
                imageUrl=document.body().select(".infobox.biography.vcard img").get(0).attr("src");
            }
            catch (Exception e)
            {

            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        WikiResult wikiResult = new WikiResult(this.keyword,responce,imageUrl);

        //push result into database

        return wikiResult;
    }

    private String getWikipediaUrlForQuery(String cleanKeyword) {
        return "https://en.wikipedia.org/wiki/"+cleanKeyword;
    }


}

