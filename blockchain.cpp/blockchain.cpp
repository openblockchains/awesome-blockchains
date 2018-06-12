#include <iostream>
#include <sstream>
#include <ctime>
#include <string>
#include <vector>
#include <iomanip>
#include <openssl/sha.h>
using namespace std;

string calc_sha256(const string str) {
    unsigned char hash[SHA256_DIGEST_LENGTH];
    SHA256_CTX sha256;
    SHA256_Init(&sha256);
    SHA256_Update(&sha256, str.c_str(), str.size());
    SHA256_Final(hash, &sha256);
    stringstream ss;
    for(int i = 0; i < SHA256_DIGEST_LENGTH; i++)
    {
        ss << hex << setw(2) << setfill('0') << (int)hash[i];
    }
    return ss.str();
}

class Block {
private:
    string data;
    string previous_hash;
    string timestamp;


public:
    int index;
    string hash;

    Block(int index, string data, string previous_hash) {
        this->index = index;
        
        std::time_t result = std::time(nullptr);
        this->timestamp = asctime(std::localtime(&result));
        this->timestamp.pop_back();

        this->data = data;
        this->previous_hash = previous_hash;
        this->hash = calc_hash();
    }

    string calc_hash() {
        string sha= to_string(this->index) +
               this->timestamp +
               this->data +
               this->previous_hash;
    return calc_sha256(sha);

    }

    string sstr() {
        stringstream ss;
        ss<< "Block<\n  index: "<< this->index<<",\n  timestamp: "<<this->timestamp<<",\n  data: "<<this->data<<",\n  previous_hash: "<<this->previous_hash<<",\n  hash: "<<this->hash<<endl;
        return ss.str();
    }

};

Block first(string data="Genesis") {
    return Block(0, data, "0");
}

Block next(Block previous, string data="Transaction Data...") {
    return Block(previous.index+1, data, previous.hash);
}



int main() {
    Block b0 = first();
    Block b1 = next( b0, "Transaction Data..." );
    Block b2 = next( b1, "Transaction Data......" );
    Block b3 = next( b2, "More Transaction Data..." );
    vector<Block> blockchain{b0, b1, b2, b3};
    for(Block v: blockchain) {
        cout<<v.sstr()<<" ";
    }
}

/*
How to compile:
 g++ blockchain.cpp -lssl -lcrypto

How to run:
 ./a.exe

will print something like:

Block<
  index: 0,
  timestamp: Mon Jun 11 20:04:42 2018,
  data: Genesis,
  previous_hash: 0,
  hash: 7270328bcf981ef958dcdaa8ae8103c6dc55307e2034415e769db0294c815ce7
 Block<
  index: 1,
  timestamp: Mon Jun 11 20:04:42 2018,
  data: Transaction Data...,
  previous_hash: 7270328bcf981ef958dcdaa8ae8103c6dc55307e2034415e769db0294c815ce7,
  hash: db4c2788a605c35665fbc5f2764bf59a0dae9c1a93faddc99b43ebcbc28a1445 Block<
  index: 2,
  timestamp: Mon Jun 11 20:04:42 2018,
  data: Transaction Data......,
  previous_hash: db4c2788a605c35665fbc5f2764bf59a0dae9c1a93faddc99b43ebcbc28a1445,
  hash: 8b2c395d669796672f732fd9bed3a5690726ec77f941ce975887fec90fb21670
 Block<  index: 3,
  timestamp: Mon Jun 11 20:04:42 2018,
  data: More Transaction Data...,
  previous_hash: 8b2c395d669796672f732fd9bed3a5690726ec77f941ce975887fec90fb21670,
  hash: eb3037acfd478230dd8ef23f24851b9d3905b098ea9e05b08c0eeaea5a117699
  */